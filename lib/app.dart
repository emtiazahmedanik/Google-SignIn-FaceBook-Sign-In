import 'package:authentication_practice_project/controllerBinder.dart';
import 'package:authentication_practice_project/feature/auth/ui/screen/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'feature/home/ui/screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication',
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:  ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ),
      home: CreateAccountScreen(),
    );
  }
}