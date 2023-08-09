
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_arch/utils/toast_util.dart';

Future<T?> safeApiCall<T>(Function apiCall) async {
  try {
    return apiCall.call();
  } catch (e) {
    showToast(msg: "请求失败");
    debugPrint("$e");
  }
  return null;
}
