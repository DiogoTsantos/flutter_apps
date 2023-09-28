class Channel {
  String id;
  String title;
  String description;
  String thumbnails;
  int    viewCount;
  int    subscriberCount;

  Channel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnails,
    required this.viewCount,
    required this.subscriberCount
  });
}