import 'dart:io';

import 'package:dart_clean_movies/app/core/config/config.dart';
import 'package:dart_clean_movies/app/core/routes/routes.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/widgets/dialogs/generic_dialog.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/fetch_movies_list_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/get_movies_list_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/states/trending_movies_list_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/trending_movies_list_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/widgets/cards/movie_list_card.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/widgets/shimers/shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrendingMoviesListPage extends StatefulWidget {
  final String timeWindow;

  const TrendingMoviesListPage({Key? key, required this.timeWindow})
      : super(key: key);

  @override
  _TrendingMoviesListPageState createState() => _TrendingMoviesListPageState();
}

class _TrendingMoviesListPageState extends State<TrendingMoviesListPage> {
  final GetTrendingMoviesBloc getTrendingMoviesBloc =
      Modular.get<GetTrendingMoviesBloc>();

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getTrendingMoviesBloc.add(GetMoviesListEvent(TrendingRequestParameters(
      page: 1,
      language: Platform.localeName.replaceAll('_', '-'),
      locationLanguage: Platform.localeName.split('_').first,
      timeWindow: widget.timeWindow,
    )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Trending movies of ${widget.timeWindow}', maxLines: 2),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<GetTrendingMoviesBloc, GeneralStates>(
                  bloc: getTrendingMoviesBloc,
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.75
                            : MediaQuery.of(context).size.height * 0.6,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                const ListCardShimmer(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemCount: 20),
                      );
                    }
                    return getTrendingMoviesBloc.movies.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SvgPicture.asset('assets/images/empty_svg.svg'),
                              const SizedBox(
                                height: 32,
                              ),
                              Center(
                                child: Text(
                                  'Não há items para listar',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                                if (!getTrendingMoviesBloc.lastPage) {
                                  getTrendingMoviesBloc.page++;
                                  getTrendingMoviesBloc.lastPage = true;
                                  getTrendingMoviesBloc.add(
                                    FetchTrendingMoviesListEvent(
                                      TrendingRequestParameters(
                                        page: getTrendingMoviesBloc.page,
                                        language: Platform.localeName
                                            .replaceAll('_', '-'),
                                        locationLanguage: Platform.localeName
                                            .split('_')
                                            .first,
                                        timeWindow: widget.timeWindow,
                                      ),
                                    ),
                                  );
                                }
                              }
                              return true;
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.height *
                                          0.75
                                      : MediaQuery.of(context).size.height *
                                          0.6,
                                  child: RefreshIndicator(
                                    color: Theme.of(context).highlightColor,
                                    onRefresh: () async {
                                      getTrendingMoviesBloc.page = 1;
                                      getTrendingMoviesBloc.lastPage = false;
                                      getTrendingMoviesBloc.add(
                                        GetMoviesListEvent(
                                          TrendingRequestParameters(
                                            page: getTrendingMoviesBloc.page,
                                            language: Platform.localeName
                                                .replaceAll('_', '-'),
                                            locationLanguage: Platform
                                                .localeName
                                                .split('_')
                                                .first,
                                            timeWindow: widget.timeWindow,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          if (state
                                              is FetchTrendingMovieListLoading) {
                                            return const ListCardShimmer();
                                          }
                                          return MovieListCard(
                                            onTap: () => Modular.to.pushNamed(
                                                Routes.movieDetail,
                                                arguments: getTrendingMoviesBloc
                                                    .movies[index]),
                                            imagePath:
                                                '${ServerConfiguration.serverImages}${getTrendingMoviesBloc.movies[index].posterPath}',
                                            title: getTrendingMoviesBloc
                                                .movies[index].title,
                                            voteAverage: getTrendingMoviesBloc
                                                .movies[index].voteAverage,
                                            overview: getTrendingMoviesBloc
                                                .movies[index].overview,
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(),
                                        itemCount: getTrendingMoviesBloc
                                            .movies.length),
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                  listener: (context, state) {
                    switch (state.runtimeType) {
                      case NotFoundState:
                        return GenericDialog.showGenericDialog(
                          context: context,
                          isError: true,
                          onPressed: () => Modular.to.pop(),
                          message: (state as NotFoundState)
                              .messageFailure
                              .failureMessage,
                          title: 'Erro!',
                        );
                      case UnauthorizedState:
                        return GenericDialog.showGenericDialog(
                          context: context,
                          isError: true,
                          onPressed: () => Modular.to.pop(),
                          message: (state as UnauthorizedState)
                              .messageFailure
                              .failureMessage,
                          title: 'Erro!',
                        );
                      case GetTrendingMovieListFailureState:
                        return GenericDialog.showGenericDialog(
                          context: context,
                          isError: true,
                          onPressed: () => Modular.to.pop(),
                          message: (state as GetTrendingMovieListFailureState)
                              .messageFailure
                              .failureMessage,
                          title: 'Erro!',
                        );
                      case FetchTrendingMovieListFailureState:
                        return GenericDialog.showGenericDialog(
                          context: context,
                          isError: true,
                          onPressed: () => Modular.to.pop(),
                          message: (state as FetchTrendingMovieListFailureState)
                              .messageFailure
                              .failureMessage,
                          title: 'Erro!',
                        );
                      case GeneralFailureState:
                        return GenericDialog.showGenericDialog(
                          context: context,
                          isError: true,
                          onPressed: () => Modular.to.pop(),
                          message: (state as GeneralFailureState)
                              .messageFailure
                              .failureMessage,
                          title: 'Erro!',
                        );
                      case TimeWindowEmptyFailureState:
                        return GenericDialog.showGenericDialog(
                          context: context,
                          isError: true,
                          onPressed: () => Modular.to.pop(),
                          message: (state as TimeWindowEmptyFailureState)
                              .timeWindowEmptyFailure
                              .failureMessage,
                          title: 'Erro!',
                        );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
