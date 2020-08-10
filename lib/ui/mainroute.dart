import 'package:flutter/material.dart';
import 'package:post_feed/db/post.dart';
import '../network/getdatafromapi.dart';
import 'userfuturebuilder.dart';
import 'commentsfuturebuilder.dart';
import '../db/dbengine.dart';

class MainRoute extends StatefulWidget {
  MainRoute({Key key, this.title, this.engine}) : super(key: key);
  final String title;
  final Engine engine;

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {

  List postsData;

  final String postsURL = "https://jsonplaceholder.typicode.com/posts";
  final String usersURL = "https://jsonplaceholder.typicode.com/users";
  final String commentsURL = "https://jsonplaceholder.typicode.com/comments";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),


      body: FutureBuilder(
          future: getDataFromAPI(postsURL),
          builder: (context, snapshot) {
            postsData = snapshot.data;
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Failed to load data",
                ),
              );
            } else if (snapshot.hasData) {

              //write posts to database
              for (int i=0; i<postsData.length; i++){
                Post post = new Post(
                  id:postsData[i]['id'],
                  userId:postsData[i]['userId'],
                  title:postsData[i]['title'],
                  body:postsData[i]['body'],
                );
                widget.engine.insertPost(post);
              }

              //list of posts

              return ListView.builder(
                  itemCount: postsData.length,
                  itemBuilder: (context, index) {
                    Text title=Text(
                      postsData[index]['title'],
                    );

                    Text description=Text(
                        postsData[index]['body'],
                        style: Theme.of(context).textTheme.body2,
                    );

                    // post
                    return Card(
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            userFutureBuilder(usersURL, postsData, index, widget.engine),
                            Divider(),
                            title,
                            Divider(),
                            description,
                            commentsFutureBuilder(commentsURL, postsData, index, widget.engine),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}