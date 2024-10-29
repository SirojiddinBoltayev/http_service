//
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:dio/dio.dart';
//
//
// class CachedInterceptor extends Interceptor {
//   final bool? requiredPost;
//
//   CachedInterceptor({this.requiredPost});
//
//
//   @override
//   onRequest(options, handler) {
//     handler.next(options);
//   }
//
//
//   @override
//   onResponse(response, handler) async {
//     if ((requiredPost ?? response.requestOptions.method != "POST") &&
//         response.requestOptions.method != "PUT" &&
//         response.requestOptions.method != "DELETE" &&
//         response.requestOptions.method != "DEL") {
//       if (response.data != null) {
//         if (response.statusCode == 200) {
//           final data = json.encode(response.data);
//
//           // await LocalStorage.instance.setDataCache(
//           //     response.requestOptions.path.toString(),
//           //     data: data);
//           //
//           // final decoded = json.decode(LocalStorage.instance
//           //     .getDataCacheString(response.requestOptions.path.toString()));
//
//           handler.next(Response(
//               requestOptions: response.requestOptions,
//               data: "decoded",
//               statusMessage: response.statusMessage,
//               extra: response.extra,
//               headers: response.headers,
//               redirects: response.redirects,
//               statusCode: response.statusCode));
//         } else {
//           try{
//
//
//
//             final decoded = json.decode(LocalStorage.instance
//                 .getDataCacheString(response.requestOptions.path));
//             log("Faiulure:  $decoded");
//             handler.next(Response(
//                 requestOptions: response.requestOptions,


//                 data: decoded,
//                 statusMessage: response.statusMessage,
//                 extra: response.extra,
//                 headers: response.headers,
//                 redirects: response.redirects,
//                 statusCode: response.statusCode));
//           }catch(e){
//             log("Faiulure:  $e");
//             handler.next(response);
//           }
//         }
//       }
//     } else {
//       handler.next(response);
//     }
//
//   }
//
//   @override
//   onError(err, handler) {
//     if ((requiredPost ?? err.requestOptions.method != "POST") &&
//         err.requestOptions.method != "PUT" &&
//         err.requestOptions.method != "DELETE" &&
//         err.requestOptions.method != "DEL") {
//       if (LocalStorage.instance
//           .getDataCacheString(err.requestOptions.path.toString())
//           .isNotEmpty) {
//
//         try {
//           final decoded = json.decode(LocalStorage.instance
//               .getDataCacheString(err.requestOptions.path.toString()));
//           log("Faiulure:  $decoded");
//
//
//           handler.next(DioException(
//               requestOptions: err.requestOptions,
//               response: Response(
//                 requestOptions: err.requestOptions,
//                 data: decoded,
//                 statusCode: err.response?.statusCode,
//               ),
//               type: err.type,
//               error: err.error),
//
//           );
//         }catch(e){
//           log("Faiulure:  $e");
//           handler.next(err);
//         }
//       }
//     } else {
//       handler.next(err);
//     }
//   }
// }