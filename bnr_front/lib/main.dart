import 'package:bnr_front/environments/environmet.dart';
import 'package:flutter/material.dart';

import 'environments/theme/app_theme.dart';
import 'shared/routes/app_routes.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
String environment = const String.fromEnvironment('ENVIRONMENT',
defaultValue: Environment.dev);
Environment().initConfig(environment);
runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienes Raices',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      initialRoute: AppRoutes.initialRoute,
      routes : AppRoutes.routes
    );
  }
}