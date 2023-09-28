import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/models/video.dart';
import 'package:youtube/video_list.dart';

class Start extends StatefulWidget {
  String? searchTerm;
 
  Start(this.searchTerm, {super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final Api _api = Api();

  Future<List<Video>> _listVideo(String? term) {
    return _api.searchVideos(widget.searchTerm!);
  }

  @override
  Widget build(BuildContext context) {
    return ListVideos(_listVideo);
  }
}