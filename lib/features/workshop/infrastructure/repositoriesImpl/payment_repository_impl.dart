import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:jappcare/core/exceptions/base_exception.dart';
import 'package:jappcare/core/services/localServices/local_storage_service.dart';
import 'package:jappcare/core/utils/app_constants.dart';
import '../../domain/core/exceptions/payment_exception.dart';
import '../../domain/core/utils/payment_constants.dart';
import '../../domain/entities/payment.entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../models/payment.model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final Dio _dio;
  final LocalStorageService _localStorage = Get.find<LocalStorageService>();

  PaymentRepositoryImpl() : _dio = Dio() {
    _dio.options.baseUrl = AppConstants.baseUrl;
  }

  Future<Map<String, String>> _getHeaders() async {
    final String token = await _localStorage.read(AppConstants.tokenKey) ?? '';
    return {
      'Accept': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  @override
  Future<Either<PaymentException, PaymentEntity>> makeCashPayment({
    required String invoiceId,
    required double amount,
    String currency = 'XAF',
    String? note,
    File? receiptFile,
  }) async {
    try {
      final headers = await _getHeaders();

      // Build payment JSON
      final paymentData = {
        'invoiceId': invoiceId,
        'money': {
          'amount': amount,
          'currency': currency,
        },
        'paymentMethod': PaymentMethod.cash,
        if (note != null && note.isNotEmpty) 'note': note,
      };

      Response response;

      if (receiptFile != null) {
        // Multipart request with receipt file
        final formData = FormData();

        // Add payment JSON as a blob
        formData.files.add(MapEntry(
          'payment',
          MultipartFile.fromString(
            jsonEncode(paymentData),
            contentType: DioMediaType('application', 'json'),
          ),
        ));

        // Add receipt file
        final fileName = receiptFile.path.split('/').last;
        final extension = fileName.split('.').last.toLowerCase();
        String mimeType = 'image/jpeg';
        if (extension == 'pdf') {
          mimeType = 'application/pdf';
        } else if (extension == 'png') {
          mimeType = 'image/png';
        }

        formData.files.add(MapEntry(
          'receiptFile',
          await MultipartFile.fromFile(
            receiptFile.path,
            filename: fileName,
            contentType: DioMediaType.parse(mimeType),
          ),
        ));

        response = await _dio.post(
          PaymentConstants.makePaymentPostUri,
          data: formData,
          options: Options(headers: headers),
        );
      } else {
        // Simple JSON request without file
        headers['Content-Type'] = 'application/json';
        response = await _dio.post(
          PaymentConstants.makePaymentPostUri,
          data: paymentData,
          options: Options(headers: headers),
        );
      }

      final data = response.data;
      return Right(PaymentModel.fromJson(data['data']).toEntity());
    } on DioException catch (e) {
      String errorMessage = 'Payment failed';
      int statusCode = e.response?.statusCode ?? 500;

      if (e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data['details'] ?? data['message'] ?? errorMessage;
        }
      }

      return Left(PaymentException(errorMessage, statusCode));
    } on BaseException catch (e) {
      return Left(PaymentException(e.message, e.statusCode));
    } catch (e) {
      return Left(PaymentException(e.toString(), 500));
    }
  }

  @override
  Future<Either<PaymentException, PaymentEntity>> getPaymentById({
    required String paymentId,
  }) async {
    try {
      final headers = await _getHeaders();
      headers['Content-Type'] = 'application/json';

      final response = await _dio.get(
        '${PaymentConstants.getPaymentsUri}/$paymentId',
        options: Options(headers: headers),
      );

      final data = response.data;
      return Right(PaymentModel.fromJson(data['data']).toEntity());
    } on DioException catch (e) {
      String errorMessage = 'Failed to get payment';
      int statusCode = e.response?.statusCode ?? 500;

      if (e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data['details'] ?? data['message'] ?? errorMessage;
        }
      }

      return Left(PaymentException(errorMessage, statusCode));
    } catch (e) {
      return Left(PaymentException(e.toString(), 500));
    }
  }

  @override
  Future<Either<PaymentException, List<PaymentEntity>>> getPayments({
    String? invoiceId,
    String? orderId,
  }) async {
    try {
      final headers = await _getHeaders();
      headers['Content-Type'] = 'application/json';

      final queryParams = <String, dynamic>{};
      if (invoiceId != null) queryParams['invoiceId'] = invoiceId;
      if (orderId != null) queryParams['orderId'] = orderId;

      final response = await _dio.get(
        PaymentConstants.getPaymentsUri,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      final data = response.data;
      final List<dynamic> paymentsJson = data['data'] ?? [];
      final payments = paymentsJson
          .map((json) => PaymentModel.fromJson(json).toEntity())
          .toList();

      return Right(payments);
    } on DioException catch (e) {
      String errorMessage = 'Failed to get payments';
      int statusCode = e.response?.statusCode ?? 500;

      if (e.response?.data != null) {
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data['details'] ?? data['message'] ?? errorMessage;
        }
      }

      return Left(PaymentException(errorMessage, statusCode));
    } catch (e) {
      return Left(PaymentException(e.toString(), 500));
    }
  }
}
