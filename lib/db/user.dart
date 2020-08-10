class User {
  final int id;
  final String name;

  User({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }
}