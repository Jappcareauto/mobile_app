import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:path_provider/path_provider.dart';
import '../../navigation/routes/app_routes.dart';
import '../localServices/local_storage_service.dart';
import 'network_service.dart';
// Talker imports commented out - uncomment for debugging
// import 'package:talker/talker.dart';
// import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../../utils/app_constants.dart';
import '../../exceptions/base_exception.dart';

class DioNetworkService extends NetworkService {
  final LocalStorageService _localStorage = Get.find<LocalStorageService>();
  final Dio _dio = Dio();
  // final Talker _talker = Talker(); // Uncomment for debugging
  late CacheOptions _cacheOptions;
  late CacheStore _cacheStore;
  bool _isRefreshing = false;

  DioNetworkService();

  Future<void> init() async {
    _dio.options.baseUrl = AppConstants.baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Directory appDocDir = await getApplicationDocumentsDirectory();
    _cacheStore = FileCacheStore('${appDocDir.path}/cache');

    // Configuration des options de cache
    _cacheOptions = CacheOptions(
      store: _cacheStore,
      policy: CachePolicy.refresh,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 3),
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    // Ajout de l'intercepteur de cache
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));

    // TalkerDioLogger disabled for production - uncomment for debugging
    // _dio.interceptors.add(
    //   TalkerDioLogger(
    //     talker: _talker,
    //     settings: const TalkerDioLoggerSettings(
    //       printRequestHeaders: true,
    //       printResponseHeaders: false,
    //       printRequestData: true,
    //       printResponseData: true,
    //     ),
    //   ),
    // );

    // Ajout d'un intercepteur pour gérer les erreurs de cache
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (_isNetworkError(error)) {
            final cacheResponseFuture = _cacheOptions.store?.get(
              _cacheOptions.keyBuilder(error.requestOptions),
            );

            if (cacheResponseFuture != null) {
              final cacheResponse = await cacheResponseFuture;
              if (cacheResponse != null && !cacheResponse.isStaled()) {
                final response = cacheResponse.toResponse(error.requestOptions);
                return handler.resolve(response);
              }
            }
          }

          // If the token is invalid, try to refresh it
          if (error.response?.statusCode == 401) {
            // Try to refresh the token
            final refreshed = await _refreshToken();
            if (refreshed) {
              // Retry the original request with new token
              try {
                final retryResponse = await _retryRequest(error.requestOptions);
                return handler.resolve(retryResponse);
              } catch (retryError) {
                // If retry fails, logout the user
                await _logoutUser();
                return handler.next(error);
              }
            } else {
              // Token refresh failed, logout the user silently
              await _logoutUser();
            }
          }
          // Passer l'erreur au prochain intercepteur si aucune réponse de cache n'est disponible
          return handler.next(error);
        },
      ),
    );
  }

  /// Refreshes the authentication token using the refresh token
  Future<bool> _refreshToken() async {
    if (_isRefreshing) {
      // Wait for the current refresh to complete
      return Future.delayed(
          const Duration(milliseconds: 500), () => _refreshToken());
    }

    _isRefreshing = true;

    try {
      final refreshToken =
          await _localStorage.read(AppConstants.refreshTokenKey);

      if (refreshToken == null || refreshToken.isEmpty) {
        _isRefreshing = false;
        return false;
      }

      // Create a separate Dio instance to avoid interceptor loops
      final refreshDio = Dio();
      refreshDio.options.baseUrl = AppConstants.baseUrl;
      refreshDio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await refreshDio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final newAccessToken =
            data['data']?['accessToken'] ?? data['accessToken'];
        final newRefreshToken =
            data['data']?['refreshToken'] ?? data['refreshToken'];

        if (newAccessToken != null) {
          await _localStorage.write(AppConstants.tokenKey, newAccessToken);
          if (newRefreshToken != null) {
            await _localStorage.write(
                AppConstants.refreshTokenKey, newRefreshToken);
          }
          _isRefreshing = false;
          return true;
        }
      }

      _isRefreshing = false;
      return false;
    } catch (e) {
      print('Token refresh failed: $e');
      _isRefreshing = false;
      return false;
    }
  }

  /// Retries a failed request with the new token
  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final token = await _localStorage.read(AppConstants.tokenKey) ?? '';

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  /// Logs out the user silently without showing session expired message
  Future<void> _logoutUser() async {
    Get.showLoader();
    await _localStorage.delete(AppConstants.tokenKey);
    await _localStorage.delete(AppConstants.refreshTokenKey);
    Get.closeLoader();
    await Get.offAllNamed(AppRoutes.home);
    // Don't show "session expired" message - user should only see logout when they manually logout
  }

  /// Vérifie si l'erreur est liée à un problème de réseau
  bool _isNetworkError(DioException error) {
    return error.type == DioException.connectionTimeout ||
        error.type == DioException.sendTimeout ||
        error.type == DioException.receiveTimeout ||
        (error.type == DioExceptionType.unknown &&
            error.error is SocketException);
  }

  /// Méthode pour obtenir les en-têtes avec le token
  Future<Map<String, String>> _getHeaders(Map<String, String>? headers) async {
    final String token = await _localStorage.read(AppConstants.tokenKey) ?? '';
    final existingHeaders = _dio.options.headers
        .map((key, value) => MapEntry(key, value.toString()));
    return {
      ...existingHeaders,
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
      ...?headers,
    };
  }

  void _handleError(dynamic error) {
    String errorMessage = 'An error occurred. Please try again.';
    int? statusCode = 500;
    print('Error Programmed-${error.toString()}');
    if (error is DioException) {
      statusCode = error.response?.statusCode;
      if (error.response != null && error.response?.data != null) {
        final data = error.response?.data;
        if (data is Map<String, dynamic> &&
            (data.containsKey('message') ||
                data.containsKey('details') ||
                data.containsKey('error'))) {
          // Get the API error message - check 'error' field first (backend format), then 'details', then 'message'
          final apiMessage =
              data['error'] ?? data['details'] ?? data['message'];
          errorMessage = _getUserFriendlyErrorMessage(apiMessage, statusCode);
        } else if (data is String && data.isNotEmpty) {
          errorMessage = _getUserFriendlyErrorMessage(data, statusCode);
        } else {
          errorMessage = _getErrorMessageByStatusCode(statusCode);
        }
      } else {
        errorMessage = _getErrorMessageByStatusCode(statusCode);
      }
    } else {
      errorMessage = 'An error occurred. Please try again.';
    }
    throw BaseException(errorMessage, statusCode);
  }

  bool _isPseudoSuccessPayload(dynamic data) {
    if (data is! Map<String, dynamic>) return false;
    final meta = data['meta'];
    if (meta is! Map<String, dynamic>) return false;

    final int? statusCode = meta['statusCode'] is int
        ? meta['statusCode'] as int
        : int.tryParse(meta['statusCode']?.toString() ?? '');
    final String statusDescription =
        (meta['statusDescription']?.toString() ?? '').toUpperCase();

    return statusCode == 200 ||
        statusCode == 201 ||
        statusDescription == 'SUCCESS';
  }

  /// Converts API error messages to user-friendly messages
  String _getUserFriendlyErrorMessage(String? apiMessage, int? statusCode) {
    if (apiMessage == null || apiMessage.isEmpty) {
      return _getErrorMessageByStatusCode(statusCode);
    }

    // Don't show technical messages or status codes to users
    final lowerMessage = apiMessage.toLowerCase();
    if (lowerMessage.contains('exception') ||
        lowerMessage.contains('error:') ||
        lowerMessage.contains('statuscode') ||
        RegExp(r'^\d{3}').hasMatch(apiMessage)) {
      return _getErrorMessageByStatusCode(statusCode);
    }

    return apiMessage;
  }

  /// Returns a user-friendly error message based on HTTP status code
  String _getErrorMessageByStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input and try again.';
      case 401:
        return 'Your session has expired. Please log in again.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'The requested resource was not found.';
      case 409:
        return 'This action conflicts with existing data. Please try again.';
      case 422:
        return 'The provided data is invalid. Please check and try again.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Server error. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  /// Création de FormData pour les requêtes avec fichiers
  Future<FormData> _createFormData(
      dynamic body, Map<String, File> files) async {
    final formData = FormData();
    if (body != null && body is Map<String, dynamic>) {
      body.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });
    }
    for (var entry in files.entries) {
      formData.files.add(MapEntry(
        entry.key,
        await MultipartFile.fromFile(
          entry.value.path,
          filename: entry.value.path.split('/').last,
        ),
      ));
    }
    return formData;
  }

  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: await _getHeaders(headers),
        ).copyWith(
          extra: _cacheOptions.toExtra(),
        ),
      );
      return response.data;
    } catch (e) {
      print(e);
      _handleError(e);
    }
  }

  @override
  Future<dynamic> post(String url,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, File>? files}) async {
    try {
      final data = files != null && files.isNotEmpty
          ? await _createFormData(body, files)
          : body;
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: await _getHeaders(headers),
        ).copyWith(
          extra: _cacheOptions.toExtra(),
        ),
      );
      return response.data;
    } catch (e) {
      if (e is DioException && _isPseudoSuccessPayload(e.response?.data)) {
        print(
            'DioNetworkService: treating non-2xx response as success based on meta payload for $url');
        return e.response?.data;
      }
      _handleError(e);
      print("error in dio network services");
      print(e);
    }
  }

  @override
  Future<dynamic> put(String url,
      {Map<String, String>? headers,
      dynamic body,
      Map<String, File>? files}) async {
    try {
      final data = files != null && files.isNotEmpty
          ? await _createFormData(body, files)
          : body;

      final response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: await _getHeaders(headers),
        ).copyWith(
          extra: _cacheOptions.toExtra(),
        ),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> delete(String url,
      {Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await _dio.delete(
        url,
        data: body,
        options: Options(
          headers: await _getHeaders(headers),
        ).copyWith(
          extra: _cacheOptions.toExtra(),
        ),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<dynamic> patch(String url,
      {Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await _dio.patch(
        url,
        data: body,
        options: Options(
          headers: await _getHeaders(headers),
        ).copyWith(
          extra: _cacheOptions.toExtra(),
        ),
      );
      return response.data;
    } catch (e) {
      _handleError(e);
    }
  }

  /// Méthode pour vider le cache si nécessaire
  Future<void> clearCache() async {
    await _cacheOptions.store?.clean();
  }
}
