import 'package:consome_webservice_avancado/post.dart';
import 'package:flutter/material.dart';

class FormBlog extends StatelessWidget {
  final Post? post;
  final Function _action_callback;
  const FormBlog(this._action_callback, {this.post, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController(
      text: post != null ? post?.title : ''
    );
    TextEditingController content = TextEditingController(
      text: post != null ? post?.body : ''
    );

    String alertTitle = (post != null) ? 'Atualizar' : 'Nova';

    return AlertDialog(
      title: Text('$alertTitle Postagem'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: title,
            decoration: const InputDecoration(
              labelText: 'Título'
            ),
          ),
          TextField(
            controller: content,
            maxLines: 8,
            decoration: const InputDecoration(
              labelText: 'Conteúdo'
            ),
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => _action_callback( title, content ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue
          ),
          child: Text('$alertTitle'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red
          ),
          child: const Text(
            'Cancelar',
          ),
        )
      ],
    );
  }
}