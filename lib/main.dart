import 'package:flutter/material.dart';
import 'package:flutter_application_2/configs/routes.dart';
import 'package:flutter_application_2/views/login.dart';
// ignore: unused_import
import 'package:flutter_application_2/views/registaration.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/data/tenant_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TenantData(),
      child: GradingApp(),
    ),
  );
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