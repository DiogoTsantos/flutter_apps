import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/models/video.dart';
import 'package:youtube/video_list.dart';

class OnTheRise extends StatefulWidget {
  const OnTheRise({super.key});

  @override
  State<OnTheRise> createState() => _OnTheRiseState();
}

class _OnTheRiseState extends State<OnTheRise> {
  final Api _api = Api();

  Future<List<Video>> _getMostPopularVideo(String? term) {
    return _api.getMostPopular();
  }

  @override
  Widget build(BuildContext context) {
    return ListVideos(_getMostPopularVideo);
  }
}