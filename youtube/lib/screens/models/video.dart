class Video {
  String id;
  String title;
  String thumbnail;
  String channel;
  String description;

  Video({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.channel,
    required this.description
  });

  factory Video.fromJson(Map<String,dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnail: json['snippet']['thumbnails']['high']['url'],
      channel: json['snippet']['channelTitle'],
      description: json['snippet']['description']
    );
  }
}