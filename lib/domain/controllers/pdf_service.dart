// Create this file: lib/services/pdf_service.dart
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'dart:developer';

class PdfService {
  static final Dio _dio = Dio();

  static Future<Uint8List?> downloadPdf(
    String url, {
    Function(int received, int total)? onProgress,
    Duration? timeout,
  }) async {
    try {
      log('Starting PDF download: $url');
      
      final response = await _dio.get(
        url.trim(),
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'User-Agent': 'Flutter PDF Viewer',
            'Accept': 'application/pdf, */*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Cache-Control': 'no-cache',
          },
          receiveTimeout: timeout ?? const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 10),
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            log('Download progress: ${(received / total * 100).toStringAsFixed(0)}%');
            onProgress?.call(received, total);
          }
        },
      );

      if (response.statusCode == 200) {
        final data = Uint8List.fromList(response.data);
        log('PDF downloaded successfully. Size: ${data.length} bytes');
        
        // Validate that it's actually a PDF
        if (data.length < 4 || !_isPdfData(data)) {
          throw Exception('Downloaded file is not a valid PDF');
        }
        
        return data;
      } else {
        throw Exception('HTTP Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      log('Dio error downloading PDF: ${e.toString()}');
      rethrow;
    } catch (e) {
      log('Error downloading PDF: $e');
      rethrow;
    }
  }

  static bool _isPdfData(Uint8List data) {
    // Check for PDF signature
    if (data.length >= 4) {
      final signature = String.fromCharCodes(data.sublist(0, 4));
      return signature == '%PDF';
    }
    return false;
  }

  static String formatDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.receiveTimeout:
        return 'Download timeout. The file might be too large.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final statusMessage = e.response?.statusMessage;
        if (statusCode == 404) {
          return 'PDF not found (404). The file may have been moved or deleted.';
        } else if (statusCode == 403) {
          return 'Access denied (403). You don\'t have permission to access this file.';
        } else if (statusCode == 500) {
          return 'Server error (500). Please try again later.';
        }
        return 'Server error: $statusCode - $statusMessage';
      case DioExceptionType.cancel:
        return 'Download was cancelled.';
      case DioExceptionType.unknown:
        if (e.error.toString().contains('SocketException')) {
          return 'Network error. Please check your internet connection.';
        }
        return 'Network error. Please check your internet connection.';
      default:
        return 'Download failed: ${e.message}';
    }
  }

  static void dispose() {
    _dio.close();
  }
}