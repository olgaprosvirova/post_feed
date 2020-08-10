import 'package:flutter/material.dart';
import 'ui/mainroute.dart';
import 'themes/appthemedata.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db/dbengine.dart';

void main()  async {

  WidgetsFlutterBinding.ensureInitialized();
  // open database
  final dbase = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
       db.execute(
        "CREATE TABLE posts(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, body TEXT)",
      );
       db.execute(
         "CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)",
       );
       db.execute(
         "CREATE TABLE comments(id INTEGER PRIMARY KEY, postId INTEGER, name TEXT, body TEXT)",
       );
    },
    version: 1,
  );
  Engine engine = new Engine(database: await dbase);
  runApp(MyApp(
    engine: engine,
  ));
}


class MyApp extends StatelessWidget {
  final Engine engine;

  MyApp({this.engine});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(),
      home: MainRoute(title: 'Feed', engine: engine,),
    );
  }
}

