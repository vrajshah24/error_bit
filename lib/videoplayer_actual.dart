import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:better_player/better_player.dart';

class videoPlayer_actual extends StatefulWidget {
  final String video;
  const videoPlayer_actual({Key? key, required this.video}) : super(key: key);

  @override
  State<videoPlayer_actual> createState() => _videoPlayer_actualState();
}

class _videoPlayer_actualState extends State<videoPlayer_actual> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BetterPlayer.network(
        widget.video,
        betterPlayerConfiguration: BetterPlayerConfiguration(
            autoDetectFullscreenAspectRatio: true, fit: BoxFit.contain),
      ),
    );
  }
}
