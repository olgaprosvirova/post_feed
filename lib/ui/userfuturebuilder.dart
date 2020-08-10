import 'package:flutter/material.dart';
import '../network/getdatafromapi.dart';
import '../db/dbengine.dart';
import '../db/user.dart';

//returns user for post and writes users data to database

Widget userFutureBuilder (String url, List posts,int index, Engine engine) {
  List usersData;

  return FutureBuilder (
      future: getDataFromAPI(url),
      builder: (context, snapshot) {
        usersData = snapshot.data;
        if (snapshot.hasError) {
          return  Text("Failed to load data");
        } else if (snapshot.hasData) {
          for (int i=0; i<usersData.length; i++){
            User user = new User(
              id:usersData[i]['id'],
              name:usersData[i]['name'],
            );
            engine.insertUser(user);
          }

          return
            Text(
              usersData[posts[index]["userId"]]["name"] + " :",
            );
        } else {
          return CircularProgressIndicator();
        }
      }
  );
}

