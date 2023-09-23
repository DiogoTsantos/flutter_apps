import 'package:dio/dio.dart';
import 'package:consome_webservice_avancado/post.dart';

class BlogApi {
  final String _endpoint; 
  final Dio _dio;

  BlogApi()
    : _dio = Dio(),
    _endpoint = 'https://jsonplaceholder.typicode.com/';

  Future <List<Post>> getPosts() async {
    List<Post> posts = [];
    Response response;
    try {
      response = await _dio.get( "${_endpoint}posts" );
    } on Exception catch(e) {
      print('Falha ao obter lista de postagens: $e');
      return [];
    }
    if (response.data != null && response.data is List<dynamic> ) {
      for (Map item in response.data) {
        posts.add(
          Post(
            item['userId'],
            item['id'],
            item['title'],
            item['body']
          )
        );
      }
    }
    return posts;
  }

  Future<bool> addPost( Post post ) async {
    Response response;
    
    try {
      response = await _dio.post(
        "${_endpoint}posts",
        data: post.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }
        )
      ); 
    } on Exception catch (e) {
      print('Falha ao adicionar nova postagen: $e');
      return false;
    }

    if ( response.statusCode == 201 ) {
      return true;
    }

    print("Código de resposta: ${response.statusCode}");
    print("Código de resposta: ${response.data}");
    return false;
  }

  Future<bool> updatePost( Post post ) async {
    Response response;
    try {
      response = await _dio.put(
        "${_endpoint}posts/${post.id}",
        data: post.toJson(),
        options: Options(
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }
        )
      );
    } on Exception catch (e) {
      print( 'Falha ao atualizar postagem: $e' );
      return false;
    }
    

    if ( response.statusCode == 200 ) {
      return true;
    }

    print("Código de resposta: ${response.statusCode}");
    print("Código de resposta: ${response.data}");
    return false;
  }

  Future<bool> removePost( int postId ) async {
    Response response;
    try {
      response = await _dio.delete(
        "${_endpoint}posts/${postId}",
        options: Options(
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }
        )
      );
    } on Exception catch (e) {
      print('Falha ao remover postagem: $e');
      return false;
    }
    

    if ( response.statusCode == 200 ) {
      return true;
    }

    print("Código de resposta: ${response.statusCode}");
    print("Código de resposta: ${response.data}");
    return false;
  }
}