import 'package:dart_clean_movies/app/modules/home/presentation/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const HomePage(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 400),
    )
  ];
}
