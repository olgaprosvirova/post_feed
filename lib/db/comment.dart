class Comment {
  final int id;
  final int postId;
  final String name;
  final String body;

  Comment({this.id, this.postId, this.name,this.body});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'name': name,
      'body': body
    };
  }

}