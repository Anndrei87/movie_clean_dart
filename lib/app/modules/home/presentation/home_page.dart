import 'package:dart_clean_movies/app/core/routes/routes.dart';
import 'package:dart_clean_movies/app/core/shared/widgets/buttons/button_custom.dart';
import 'package:dart_clean_movies/app/modules/home/presentation/widgets/cards/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TMDB Trending Movies'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MediumButton(
                    onPressed: () => Modular.to.pushNamed(Routes.searchMovie),
                    text: 'Buscar filmes',
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selecione qual listagem de filmes você deseja',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                HomeCard(
                    onTap: () => Modular.to
                        .pushNamed(Routes.trendingMovies, arguments: 'day'),
                    title: 'Day',
                    description: 'Lista os filmes que estão em alta hoje'),
                HomeCard(
                    onTap: () => Modular.to
                        .pushNamed(Routes.trendingMovies, arguments: 'week'),
                    title: 'Week',
                    description: 'Lista os filmes que estão em alta na semana'),
              ],
            ),
          ),
        ));
  }
}
