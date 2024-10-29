import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// import '../../presantation/global_widgets/app_print_console.dart';

class OfflineInterceptor extends Interceptor {
  final Duration slowRequestThreshold;

  OfflineInterceptor({this.slowRequestThreshold = const Duration(seconds: 2)});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.extra['startTime'] = DateTime.now();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra['startTime'] as DateTime;
    final duration = DateTime.now().difference(startTime);
    if (duration > slowRequestThreshold) {
      // Ulanish past deb hisoblanadi
      // printConsole('Ulanish tezligi past. Davomiyligi: $duration');
      enableOfflineMode();
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra['startTime'] as DateTime;
    final duration = DateTime.now().difference(startTime);
    if (duration > slowRequestThreshold || err.type == DioExceptionType.connectionTimeout) {
      // Ulanish past deb hisoblanadi yoki server xatosi
      // printConsole('Ulanish tezligi past yoki xato: $duration');
      enableOfflineMode();
      if (err.requestOptions.method == 'POST') {
        savePostRequest(err.requestOptions);
      }
    }
    super.onError(err, handler);
  }

  void enableOfflineMode() {
    // Offline rejimini yoqish
    // printConsole('Offline rejim yoqildi');
  }

  void savePostRequest(RequestOptions requestOptions) {
    // POST so'rovini saqlash
    // printConsole('POST so\'rovini saqlash: ${requestOptions.uri}');
    // Saqlash mexanizmini bu yerda yozing (masalan, mahalliy saqlash yoki fayl tizimi)


  }
}


