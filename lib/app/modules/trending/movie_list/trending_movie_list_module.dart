import 'package:dart_clean_movies/app/core/routes/routes.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/usecases/get_movies_by_time_window.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/external/datasources/get_trending_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/repositories/get_trendings_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/trending_movies_list_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/pages/trending_movie_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TrendingMoviesListModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetTrendingMoviesRepositoryImplementation(i())),
    Bind((i) => GetTrendingDataSourceImplementation(i())),
    Bind((i) => GetTrendingByTimeWindow(i())),
    Bind((i) => GetTrendingMoviesBloc(i())),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => TrendingMoviesListPage(
              timeWindow: arguments.data,
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
    // ModuleRoute(Routes.movieDetailModule, module: MovieDetailModule()),
  ];
}
