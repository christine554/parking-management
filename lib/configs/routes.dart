import 'package:flutter_application_2/views/home.dart';
import 'package:flutter_application_2/views/login.dart';
import 'package:flutter_application_2/views/registaration.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

var routes = [
  GetPage(name: "/", page: () => loginscreen()),
  GetPage(name: "/signup", page: () => SINGUP()),
  GetPage(name: "/home", page: () => HomeScreen()),
];