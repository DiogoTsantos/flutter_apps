import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // close(context, query);
    Future.delayed(Duration.zero).then(
      (onValue){
        close(context, query);
      }
    );
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> sugestions = [
      'Palmeiras',
      'Rx 6600',
      'Impostos',
      'Serviço social',
      'Ravi'
    ].where(
      (element) => element.toLowerCase().startsWith(query.toLowerCase())
    ).toList();

    if ( query.isNotEmpty ) {
      return ListView.builder(
        itemCount: sugestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text( sugestions[index] ),
            onTap: () {
              close(context, sugestions[index]);
            },
          );
        },
      );
    }
    return Container();
  }
}