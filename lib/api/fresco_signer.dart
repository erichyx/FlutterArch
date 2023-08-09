import 'dart:convert';

import 'package:crypto/crypto.dart';

const String macKey = "bf7dddc7c9cfe6f7";

String generateSign(String content) {
  var key = utf8.encode(macKey);
  var bytes = utf8.encode(content);

  var hmacSha1 = Hmac(sha1, key);
  var digest = hmacSha1.convert(bytes);
  return base64Encode(digest.bytes);
}
