import 'package:flutter/material.dart';
import 'package:sign_up_ui/otp.dart';
import 'package:sign_up_ui/phone.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'phone',
      routes: {
        'phone': (context) => const MyPhone(),
        'otp': (context) => const MyOtp()
      },
    ),
  );
}
