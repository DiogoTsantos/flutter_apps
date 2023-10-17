class Anotation {
  int? id;
  String? title;
  String? description;
  String? createData;

  Anotation({
    this.id,
    required this.title,
    required this.description,
    required this.createData,
  });

  Anotation.fromMap( Map map ) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.createData = map['createData'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createData': createData
    };
  }
}