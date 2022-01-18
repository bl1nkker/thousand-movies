class Genre {
  final String id;
  final String name;

  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'];
}
