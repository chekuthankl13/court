import 'package:flutter/material.dart';

double sW(BuildContext context) => MediaQuery.sizeOf(context).width;
double sH(BuildContext context) => MediaQuery.sizeOf(context).height;

Widget spaceHeight(int val) => SizedBox(height: double.parse(val.toString()));
Widget spaceWidth(int val) => SizedBox(width: double.parse(val.toString())); 

void errorToast(BuildContext context, {msg}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));



Widget empty() => SizedBox();

Widget itemEmpty(BuildContext context, txt, {isCenter = true}) => Column(
  spacing: 20,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    isCenter ? spaceHeight((sH(context) / 3) as int) : empty(),
    Center(child: Text(txt)),
  ],
);

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


 String? errorMessage(dynamic data) {
    if (data is! Map) return null;

    final value = data['message'] ?? data['error'];
    return value is String && value.isNotEmpty ? value : null;
  }
