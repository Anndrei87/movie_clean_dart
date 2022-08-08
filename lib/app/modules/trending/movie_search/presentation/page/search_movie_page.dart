import 'dart:io';

import 'package:dart_clean_movies/app/core/config/config.dart';
import 'package:dart_clean_movies/app/core/routes/routes.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/widgets/dialogs/generic_dialog.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/widgets/inputs/custom_input.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/states/trending_movies_list_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/widgets/cards/movie_list_card.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/widgets/shimers/shimmer_list.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/events/search_movie_events.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/search_movie_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/states/search_movie_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unicons/unicons.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  final SearchMovieBloc searchMovieBloc = Modular.get<SearchMovieBloc>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Buscar filmes',
          maxLines: 2,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomInputText(
                    fillColor: Theme.of(context).primaryColor,
                    onChanged: (value) => searchMovieBloc.add(
                      SearchMovieEvent(
                        SearchMovieParameter(
                          page: searchMovieBloc.page,
                          language: Platform.localeName.replaceAll('_', '-'),
                          locationLanguage:
                              Platform.localeName.split('_').first,
                          searchValue: searchController.text,
                        ),
                      ),
                    ),
                    controller: searchController,
                    sufixIcon: UniconsLine.search_alt,
                    label: 'Buscar',
                    borderRadius: 4,
                  ),
                ),
                BlocConsumer<SearchMovieBloc, GeneralStates>(
                    bloc: searchMovieBloc,
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Container(
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.75
                              : MediaQuery.of(context).size.height * 0.6,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: ((context, index) =>
                                  const ListCardShimmer()),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(),
                              itemCount: 20),
                        );
                      }
                      return searchMovieBloc.movies.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/empty_svg.svg'),
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                    'Não há itens para listar',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  if (!searchMovieBloc.lastPage) {
                                    searchMovieBloc.page++;
                                    searchMovieBloc.lastPage = true;
                                    searchMovieBloc.add(
                                      FetchSearchMovieEvent(
                                        SearchMovieParameter(
                                          page: searchMovieBloc.page,
                                          language: Platform.localeName
                                              .replaceAll('_', '-'),
                                          locationLanguage: Platform.localeName
                                              .split('_')
                                              .first,
                                          searchValue: searchController.text,
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
                                    height: MediaQuery.of(context)
                                                .orientation ==
                                            Orientation.portrait
                                        ? MediaQuery.of(context).size.height *
                                            0.75
                                        : MediaQuery.of(context).size.height *
                                            0.6,
                                    child: RefreshIndicator(
                                      color: Theme.of(context).highlightColor,
                                      onRefresh: () async {
                                        searchMovieBloc.page = 1;
                                        searchMovieBloc.lastPage = false;
                                        searchMovieBloc.add(
                                          SearchMovieEvent(
                                            SearchMovieParameter(
                                              page: searchMovieBloc.page,
                                              language: Platform.localeName
                                                  .replaceAll('_', '-'),
                                              locationLanguage: Platform
                                                  .localeName
                                                  .split('_')
                                                  .first,
                                              searchValue:
                                                  searchController.text,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            if (state
                                                is FetchSearchMovieLoadingState) {
                                              return const ListCardShimmer();
                                            }
                                            return MovieListCard(
                                              onTap: () => Modular.to.pushNamed(
                                                  Routes.movieDetail,
                                                  arguments: searchMovieBloc
                                                      .movies[index]),
                                              imagePath: searchMovieBloc
                                                      .movies[index]
                                                      .posterPath
                                                      .isEmpty
                                                  ? ''
                                                  : '${ServerConfiguration.serverImages}${searchMovieBloc.movies[index].posterPath}',
                                              title: searchMovieBloc
                                                  .movies[index].title,
                                              voteAverage: searchMovieBloc
                                                  .movies[index].voteAverage,
                                              overview: searchMovieBloc
                                                  .movies[index].overview,
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(),
                                          itemCount:
                                              searchMovieBloc.movies.length),
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
                            message:
                                (state as FetchTrendingMovieListFailureState)
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
      ),
    );
  }
}
