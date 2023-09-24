import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/screens/models/video.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  Api _api = Api();

  _listVideo() {
    return _api.search_videos('');
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<Video>>(
      future: _listVideo(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video>? videos = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(videos![index].thumbnail)
                          )
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        title: Text(videos[index].title),
                        subtitle: Text(videos[index].channel),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 3,
                  color: Colors.red,
                ),
                itemCount: snapshot.data!.length
              );
            }
            return const Center(
              child: Text('Nenhum resultado encontrado!'),
            );
        }
      }
    );
  }
}