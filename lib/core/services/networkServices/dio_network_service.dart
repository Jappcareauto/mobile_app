import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:jappcare/core/utils/getx_extensions.dart';
import 'package:path_provider/path_provider.dart';
import '../../navigation/routes/app_routes.dart';
import '../localServices/local_storage_service.dart';
import 'network_service.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../../utils/app_constants.dart';
import '../../exceptions/base_exception.dart';

class DioNetworkService extends NetworkService {
  final LocalStorageService _localStorage = Get.find<LocalStorageService>();
  final Dio _dio = Dio();
  final Talker _talker = Talker();
  late CacheOptions _cacheOptions;
  late CacheStore _cacheStore;

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

    // Ajout de l'intercepteur TalkerDioLogger pour les logs
    _dio.interceptors.add(
      TalkerDioLogger(
        talker: _talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: false,
          printRequestData: true,
          printResponseData: true,
        ),
      ),
    );

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

          // Si le jeton est invalide, redirection vers la page de connexion
          if (error.response?.statusCode == 401) {
            Get.showLoader();
            await _localStorage.delete(AppConstants.tokenKey);
            await _localStorage.delete(AppConstants.refreshTokenKey);
            Get.closeLoader();
            await Get.offAllNamed(AppRoutes.home);
            Get.showCustomSnackBar("Veuillez vous reconnecter");
          }
          // Passer l'erreur au prochain intercepteur si aucune réponse de cache n'est disponible
          return handler.next(error);
        },
      ),
    );
  }

  /// Vérifie si l'erreur est liée à un problème de réseau
  bool _isNetworkError(DioException error) {
    return error.type == DioException.connectionTimeout ||
        error.type == DioException.sendTimeout ||
        error.type == DioException.receiveTimeout ||
        (error.type == DioErrorType.unknown && error.error is SocketException);
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
    String errorMessage = 'Une erreur est survenue';
    if (error is DioError) {
      if (error.response != null && error.response?.data != null) {
        final data = error.response?.data;
        if (data is Map<String, dynamic> &&
            (data.containsKey('message') || data.containsKey('details'))) {
          errorMessage = data['details'] ?? data['message'];
        } else if (data is String) {
          errorMessage = data;
        } else {
          errorMessage = 'Erreur du serveur : ${error.response?.statusCode}';
        }
      } else {
        errorMessage = error.message ?? 'Une erreur est survenue';
      }
    } else {
      errorMessage = error.toString();
    }
    throw BaseException(errorMessage);
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
      _handleError(e);
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
