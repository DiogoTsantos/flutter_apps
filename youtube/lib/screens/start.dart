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
  void initState() {
    super.initState();
    print('chamada 1 - inciou');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('chamada 2 - didchange');
  }

  @override
  void didUpdateWidget(covariant Start oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('chamada 2 - didupdate');
  }

  @override
  void dispose() {
    super.dispose();
    print('chamada 4 - acabou');
  }

  @override
  Widget build(BuildContext context) {
    print('chamada 3 - build');
    return ListVideos(_listVideo);
  }
}