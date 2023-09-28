import 'package:dio/dio.dart';
import 'package:youtube/models/video.dart';

class Api {
  final String _apiKey;
  final String _endpoint;
  final Dio _dio;

  Api()
    : _dio = Dio(),
    _apiKey = 'AIzaSyBtbHmvTJwqS3GgpLCodnMzcjmycSqxDXI',
    _endpoint = 'https://www.googleapis.com/youtube/v3/';

  Future<List<Video>> searchVideos( String term ) async {
    Response response = await _dio.get(
      '${_endpoint}search',
      queryParameters: {
        'part':'snippet',
        'type': 'video',
        'maxResults': 20,
        'q': term,
        'key': _apiKey
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

  Future<List<Video>> getMostPopular() async {
    Response response = await _dio.get(
      '${_endpoint}videos',
      queryParameters: {
        'part':'snippet',
        'maxResults': 20,
        'key': _apiKey,
        'chart': 'mostPopular',
        'hl': 'pt_BR'
      },
    );

    if ( response.statusCode == 200 ) {
      List<Video> videos = response.data['items'].map<Video>(
        (map) {
          return Video.fromJsonMostPopular(map);
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