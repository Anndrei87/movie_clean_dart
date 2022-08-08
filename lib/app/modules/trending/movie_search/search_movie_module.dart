import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/usecases/search_movie_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/external/datasource/search_movie_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/repositories/search_movie_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/search_movie_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/page/search_movie_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchMovieModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SearchMovieDataSourceImp(i())),
    Bind((i) => SearchMovieRepositoryImplementation(i())),
    Bind((i) => SearchMovieByQuery(i())),
    Bind((i) => SearchMovieBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => const SearchMoviePage(),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}
