import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_arch/network/fresco_interceptor.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';


final dio = Dio();

void initDio() {
  dio.options.connectTimeout = 5000; //5s
  dio.options.receiveTimeout = 5000;
  // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //     (client) {
  //   client.badCertificateCallback =
  //       (X509Certificate cert, String host, int port) {
  //     return true;
  //   };
  // };

  dio.interceptors.add(FrescoInterceptor());
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      queryParameters: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      showProcessingTime: true,
      canShowLog: kDebugMode,
    ),
  );
}
