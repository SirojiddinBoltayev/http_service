import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_service/core/handlers/server_error_interceptor.dart';
import 'package:http_service/core/handlers/token_interceptor.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'dio_transform_package.dart';

class HttpService {
  Dio client({bool requireAuth = false, bool? requiredPost}) => Dio(
        BaseOptions(
          baseUrl: "!kDebugMode ? SecretVars.baseUrlDev : SecretVars.baseUrlProd",
          connectTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          sendTimeout: const Duration(minutes: 1),
          headers: {
            'Accept': 'application/json',
            'Accept-Language': "LocalStorage.instance.getLang()",
            // 'Content-type': 'application/json',
            // 'Authorization': 'Bearer ${LocalStorage.instance.getToken()}'
          },
        ),
      )
        ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
        // ..interceptors.add(OfflineInterceptor())
        ..interceptors.add(LogInterceptor(responseBody: true, requestBody: true))
        ..interceptors.add(RequestsInspectorInterceptor())
        // ..interceptors.add(CachedInterceptor(requiredPost: requiredPost))
        // ..interceptors.add(ServerErrorInterceptor())
        ..transformer = FlutterTransformer()
  ;
}
