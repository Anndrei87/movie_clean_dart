import 'package:dart_clean_movies/app/core/packages/http_client.dart';
import 'package:dart_clean_movies/app/modules/home/home_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/routes/routes.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => RequestClientImplementation(i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Routes.home, module: HomeModule()),
  ];
}
