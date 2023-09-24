import 'package:dio/dio.dart';
import 'package:youtube/screens/models/video.dart';

class Api {
  final String _api_key;
  final String _endpoint;
  final Dio _dio;

  Api()
    : _dio = Dio(),
    _api_key = 'AIzaSyBtbHmvTJwqS3GgpLCodnMzcjmycSqxDXI',
    _endpoint = 'https://www.googleapis.com/youtube/v3/';

  Future<List<Video>> search_videos( String term ) async {
    Response response = await _dio.get(
      '${_endpoint}search',
      queryParameters: {
        'part':'snippet',
        'type': 'video',
        'maxResults': 20,
        'q': term,
        'key': _api_key
      },
    );

    if ( response.statusCode == 200 ) {
      List<Video> videos = response.data['items'].map<Video>(
        (map) {
          return Video.fromJson(map);
        }
      ).toList();
      return videos;
    } else {
      print( response.statusCode );
      print( response.data );
    }
    return [];
  }
}