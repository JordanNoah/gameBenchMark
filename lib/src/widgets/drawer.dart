import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/sharedFunction.dart';
import 'package:reactiongame_frontend/src/models/user_model.dart';
import 'package:reactiongame_frontend/src/widgets/disconected.dart';
import 'package:reactiongame_frontend/src/widgets/conected.dart';
import 'package:http/http.dart' as http;

class DrawerAplication extends StatefulWidget {
  DrawerAplication({Key key}) : super(key: key);

  @override
  _DrawerState createState() => _DrawerState();
}

Future getUserById(int userId) async {
  final String apiUrl = "http://192.168.100.54:3002/api/get_user_id/$userId";
  final response = await http.get(apiUrl);
  print(response.body);
  return response.body;
}

class _DrawerState extends State<DrawerAplication> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 4),
            children: <Widget>[
              FutureBuilder(
                future: checkIdUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data) {
                      return FutureBuilder(
                        future: getIdUser(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            return FutureBuilder(
                              future: getUserById(snapshot.data),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                var response =
                                    json.decode(snapshot.data)["status"];
                                if (response == "no-existed") {
                                  return Disconected();
                                } else {
                                  var jsonUser = json.decode(snapshot.data);
                                  var user = userModelFromJson(
                                      json.encode(jsonUser["user"]));
                                  return Conected(
                                    email: user.email,
                                    namesUser: user.name,
                                  );
                                }
                              },
                            );
                          } else {
                            return Disconected();
                          }
                        },
                      );
                    } else {
                      return Disconected();
                    }
                  } else {
                    return Disconected();
                  }
                },
              ),
              Divider(
                color: Colors.black26,
                height: 8,
                thickness: 1,
                indent: 2,
                endIndent: 2,
              ),
              ListTile(
                title: Text(
                  "Configuración",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ListTile(
                title: Text(
                  'Ajustes avanzados',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Idiomas',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                color: Colors.black26,
                height: 8,
                thickness: 1,
                indent: 2,
                endIndent: 2,
              ),
              ListTile(
                title: Text(
                  "General",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              ListTile(
                title: Text("Versión"),
                subtitle: Text("1.0.1_production"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
