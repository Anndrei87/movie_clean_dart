import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/usecases/search_movie_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/external/datasource/search_movie_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/repositories/search_movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchMovieModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SearchMovieDataSourceImp(i())),
    Bind((i) => SearchMovieRepositoryImplementation(i())),
    Bind((i) => SearchMovieByQuery(i())),
    // bloc searchMovie
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => Scaffold(),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}
