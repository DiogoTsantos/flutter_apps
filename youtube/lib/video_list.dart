import 'package:flutter/material.dart';
import 'package:youtube/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListVideos extends StatelessWidget {
  final Future<List<Video>> Function(String? term) futureResorce;
  const ListVideos(this.futureResorce, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: futureResorce(''),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator()
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video>? videos = snapshot.data;
                  return GestureDetector(
                    onTap: () {
                      YoutubePlayerController controller = YoutubePlayerController(
                        initialVideoId: videos[index].id,
                        flags: const YoutubePlayerFlags(
                          autoPlay: true,
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return YoutubePlayer(
                            controller: controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                          );
                        })
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(videos![index].thumbnail)
                            )
                          ),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          title: Text(videos[index].title),
                          subtitle: Text(videos[index].channel),
                        )
                      ],
                    ),
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