import 'package:dart_clean_movies/app/core/routes/routes.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_detail/presentation/movie_detail_page.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/usecase/movie_trailer_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/external/datasources/get_movie_trailer_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/repositories/get_movie_trailer_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/bloc/get_trailer_movie_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/page/movie_trailer_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieDetailModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetMovieTrailerResultsDataSourceImplementation(i())),
    Bind((i) => GetMovieTrailerResultsRepositoryImplementation(i())),
    Bind((i) => GetMovieTrailerByMovieId(i())),
    Bind((i) => GetMovieTrailerBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (context, arguments) => MovieDetailPage(
              movie: arguments.data,
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
    ChildRoute(Routes.movieTrailerModule,
        child: (context, arguments) => MovieTrailerPage(
              videoId: arguments.data,
            ),
        transition: TransitionType.rightToLeft,
        duration: const Duration(milliseconds: 400)),
  ];
}
