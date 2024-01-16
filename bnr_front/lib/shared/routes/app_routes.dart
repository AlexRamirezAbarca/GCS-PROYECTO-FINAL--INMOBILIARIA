import 'package:flutter/material.dart';

import '../../modules/login/pages/login_page.dart';

class AppRoutes{
  static const initialRoute = '/loginPage';

  static Map<String, Widget Function(BuildContext)> routes ={
    '/loginPage' : (_) => const LoginPage()
  };
}