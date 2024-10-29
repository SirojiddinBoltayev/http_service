// import 'package:dio/dio.dart';
// import 'package:first_open_project/core/handlers/token_interceptor.dart';
//
// import '../../constants/secret_vars.dart';
// import '../shared_preferences/local_storage.dart';
//
//
// class HttpServiceAuth {
//   Dio client({bool requireAuth = false}) => Dio(
//     BaseOptions(
//       baseUrl: SecretVars.baseUrl,
//       connectTimeout: 60 * 1000,
//       receiveTimeout: 60 * 1000,
//       sendTimeout: 60 * 1000,
//       headers: {
//         'Accept': 'application/json',
//         'Content-type': 'application/json',
//       },


//     ),
//   )
//   ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
//     ..interceptors.add(LogInterceptor(responseBody: true,requestBody: true));
// }