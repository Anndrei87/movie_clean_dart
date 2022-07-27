import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerPage extends StatefulWidget {
  final String videoId;

  const MovieTrailerPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _MovieTrailerPageState createState() => _MovieTrailerPageState();
}

class _MovieTrailerPageState extends State<MovieTrailerPage> {
  late YoutubePlayerController _videoController;

  @override
  void initState() {
    _videoController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _videoController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.white,
            ),
          ),
          builder: (context, player) {
            return Column(
              children: [
                player,
              ],
            );
          }),
    );
  }
}
