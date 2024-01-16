import 'package:flutter/material.dart';

class AppTheme { 
  ThemeData theme (){
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}