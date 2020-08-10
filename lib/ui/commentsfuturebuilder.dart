import 'package:flutter/material.dart';
import '../network/getdatafromapi.dart';
import '../db/dbengine.dart';
import '../db/comment.dart';

//builds comments section for post and writes comments data to database

Widget commentsFutureBuilder(String url, List posts, int index, Engine engine) {
  List commentsData;
  return FutureBuilder(
      future: getDataFromAPI(url),
      builder: (context, snapshot) {
        commentsData = snapshot.data;
        if (snapshot.hasError) {
          return Text("Failed to load data");
        } else if (snapshot.hasData) {
          List currentPostComments =
              getCommentsByPostID(posts[index]["id"], commentsData);

          for (int i=0; i<commentsData.length; i++){
            Comment comment = new Comment(
              id:commentsData[i]['id'],
              postId:commentsData[i]['postId'],
              name:commentsData[i]['name'],
              body:commentsData[i]['body'],
            );
            engine.insertComment(comment);
          }

          return ExpansionTile(
              title: Text("Comments ( " + currentPostComments.length.toString() + " )",
              style: Theme.of(context).textTheme.body1,
            ),
            children: <Widget>[
                SizedBox(
                  height: 150,
                  child: new ListView.builder(
                      shrinkWrap: true,
                      itemCount: currentPostComments.length,
                      itemBuilder: (BuildContext context, int index) {

                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).scaffoldBackgroundColor,
                          ),

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(currentPostComments[index]["name"] + " :",
                              ),
                              Divider(),
                              Text(
                                currentPostComments[index]["body"],
                                style: Theme.of(context).textTheme.body2,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
            ]
          );
        } else {
          return CircularProgressIndicator();
        }
      });
}

List getCommentsByPostID(int postId, List commentsData) {
  List result = new List();
  for (int i = 0; i < commentsData.length; i++) {
    if (commentsData[i]["postId"] == postId) result.add(commentsData[i]);
  }
  return result;
}
