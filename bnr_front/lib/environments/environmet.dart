import 'package:bnr_front/environments/config/base_config.dart';
import 'package:bnr_front/environments/config/dev_config.dart';
import 'package:bnr_front/environments/config/prod_config.dart';
import 'package:bnr_front/environments/config/qa_config.dart';

class Environment { 
  static final Environment _environment = Environment._internal();

  factory Environment () => _environment;

  Environment._internal();


  static const String dev = 'DEV';
  static const String qa = 'QA';
  static const String prod = 'PROD';

  BaseConfig? config;

  initConfig(String environment ) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig (String environment){
    switch(environment){
      case Environment.qa :
      return EnvQa();
      case Environment.prod :
      return EnvProd();
      default :
      return EnvDev();

    }
  }

}