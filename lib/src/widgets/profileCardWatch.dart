import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/sharedFunction.dart';
import 'package:http/http.dart' as http;
import 'package:reactiongame_frontend/src/models/user_model.dart';

class ProfileCardWatch extends StatefulWidget {
  ProfileCardWatch({Key key}) : super(key: key);

  @override
  _ProfileCardWatchState createState() => _ProfileCardWatchState();
}

Future getUser() async {
  var idUser = await getIdUser();
  final String apiUrl = "http://192.168.100.54:3002/api/get_user_id/$idUser";
  final response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return responseString;
  } else {
    return null;
  }
}

class _ProfileCardWatchState extends State<ProfileCardWatch> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var jsonToUser = json.decode(snapshot.data)["user"];
        var user = userModelFromJson(json.encode(jsonToUser));
        print(user.name);
        return Column(
          children: [
            ListTile(
              title: Text("Nombre"),
              subtitle: Text("${user.name}"),
            ),
            ListTile(
              title: Text("Correo electrónico"),
              subtitle: Text("${user.email}"),
            ),
            ListTile(
              title: Text("Password"),
              subtitle: Text("${user.password}"),
            ),
            ListTile(
              title: Text("Fecha de nacimiento"),
              subtitle: Text("${user.dateBorn}"),
            ),
            ListTile(
              title: Text("Gender"),
              subtitle: Text("${user.gender}"),
            ),
            ListTile(
              title: Text("country"),
              subtitle: Text("${user.country}"),
            )
          ],
        );
      },
    );
  }
}
