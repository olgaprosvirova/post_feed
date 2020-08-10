class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({this.id, this.userId, this.title,this.body});

 Map<String, dynamic> toMap() {
  return {
    'id': id,
    'userId': userId,
    'title': title,
    'body': body
   };
 }

  @override
  String toString() {
    return (this.id.toString()+this.userId.toString());
  }
}