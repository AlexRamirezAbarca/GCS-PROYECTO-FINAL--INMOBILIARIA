import 'package:bnr_front/modules/home_page/pages/home_page.dart';
import 'package:bnr_front/modules/register_page/pages/register_page.dart';
import 'package:flutter/material.dart';

import '../../modules/login/pages/login_page.dart';

class AppRoutes{
  static const initialRoute = '/loginPage';

  static Map<String, Widget Function(BuildContext)> routes ={
    '/loginPage' : (_) => const LoginPage(),
    '/registerPage' : (_) => const RegisterPage(),
    '/homePage' : (_) => const HomeScreen(),
  };
}