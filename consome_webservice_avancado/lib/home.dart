import 'package:consome_webservice_avancado/blog_api.dart';
import 'package:consome_webservice_avancado/form_blog.dart';
import 'package:consome_webservice_avancado/post.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BlogApi _api = BlogApi();
  List<Post> _posts = [];

  Future<void> _removePost( int postId ) async {
    bool result = await _api.removePost(postId);
    if ( result == true ) {
      setState(() {
        for ( Post post in _posts ) {
          if (post.id == postId) {
            _posts.remove(post);
            break;
          }
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
        return const AlertDialog(
            title: Text('Falha ao processar a operação!'),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _api.getPosts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator()
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError ) {
                return const Center(
                  child: Text(
                    'Falha ao carregar postagens',
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                );
              } else {
                _posts = _posts.isEmpty ? snapshot.data! : _posts;
                return ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          _posts[index].title.toString()[0].toUpperCase()+_posts[index].title.toString().substring(1),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        _posts[index].body.toString(),
                       textAlign: TextAlign.justify,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return FormBlog(
                                    (
                                      TextEditingController title,
                                      TextEditingController content) async {
                                      Post editPost = _posts[index];
                                      editPost.title = title.text;
                                      editPost.body = content.text;

                                      bool result = await _api.updatePost(editPost);
                                      if ( result == true ) {
                                        setState(() {
                                          _posts[index] = editPost;
                                        });
                                      } else {
                                        print('Falha ao atualizar postagem');
                                      }
                                      Navigator.pop(context);
                                    },
                                    post: _posts[index],
                                  );
                                }
                              );
                            },
                            icon: Icon( Icons.edit )
                          ),
                          IconButton(
                            onPressed: () {
                              _removePost(_posts[index].id);
                            },
                            icon: const Icon( Icons.remove_circle_outline )
                          )
                        ],
                      ),
                    );
                  }
                );
              }
          }
        }
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return FormBlog(
                (
                  TextEditingController title,
                  TextEditingController content) async {
                  Post newPost = Post(
                    1,
                    101,
                    title.text,
                    content.text
                  );

                  bool result = await _api.addPost(newPost);
                  if ( result == true ) {
                    setState(() {
                      _posts.add(newPost);
                    });
                  } else {
                    print('Falha ao adicionar nova postagem');
                  }
                  Navigator.pop(context);
                }
              );
            }
          );
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.blue,
        ),
        iconSize: 60,
      ),
    );
  }
}