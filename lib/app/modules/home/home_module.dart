import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const Scaffold(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 400),
    )
  ];
}
