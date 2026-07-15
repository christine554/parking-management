import 'package:flutter/material.dart';
import 'package:flutter_application_2/configs/routes.dart';
import 'package:flutter_application_2/views/login.dart';
import 'package:flutter_application_2/views/registaration.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(GradingApp());
}

class GradingApp extends StatefulWidget {
  const GradingApp({super.key});

  @override
  State<GradingApp> createState() => _GradingAppState();
}

class _GradingAppState extends State<GradingApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginscreen(),
      initialRoute: "/",
      getPages: routes,
    );
  }
}