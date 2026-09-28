import 'package:flutter/material.dart';

Widget spaceHeight(int val) => SizedBox(height: val.toDouble());
Widget spaceWidth(int val) => SizedBox(width: val.toDouble());

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String? errorMessage(dynamic data) {
  if (data is! Map) return null;

  final value = data['message'] ?? data['error'];
  return value is String && value.isNotEmpty ? value : null;
}
