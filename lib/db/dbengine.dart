import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'post.dart';
import 'user.dart';
import 'comment.dart';
// class to interact with database
// contains methods for inserting into tables

class Engine {
  final Database database;

  Engine({this.database});

  Future<void> insertPost(Post post) async {
    final Database db = this.database;
    await db.insert(
      'posts',
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertUser(User user) async {
    final Database db = this.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertComment(Comment comment) async {
    final Database db = this.database;
    await db.insert(
      'comments',
      comment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}