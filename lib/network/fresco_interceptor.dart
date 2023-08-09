import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arch/api/fresco_api.dart';
import 'package:flutter_arch/api/fresco_signer.dart';

class FrescoInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.baseUrl == Fresco.baseUrl) {
      options.headers['User-Agent'] = Fresco.userAgent;
      options.queryParameters['apikey'] = Fresco.apiKey;

      var timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      options.queryParameters['_ts'] = timestamp;

      var encodePath = Uri.encodeComponent('/${options.path}');
      var cleartext = "${options.method}&$encodePath&$timestamp";
      debugPrint("待签名内容=$cleartext");
      var sign = generateSign(cleartext);
      debugPrint("sign=$sign");
      options.queryParameters['_sig'] = sign;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint("拦截器onError():${err.message}");
    super.onError(err, handler);
  }
}
