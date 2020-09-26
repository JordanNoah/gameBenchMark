import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/src/widgets/profileCardWatch.dart';
import 'package:reactiongame_frontend/src/widgets/profileCardEdit.dart';
import 'package:reactiongame_frontend/sharedFunction.dart';

class ConfigAccount extends StatefulWidget {
  ConfigAccount({Key key}) : super(key: key);

  @override
  _ConfigAccountState createState() => _ConfigAccountState();
}

bool editProfile = false;

void closeAccount() {
  removeIdUser();
}

class _ConfigAccountState extends State<ConfigAccount> {
  @override
  void initState() {
    super.initState();
    editProfile = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Configurar cuenta"), centerTitle: true, elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: CircleAvatar(
                    radius: 27.0,
                    backgroundImage: NetworkImage(
                        'https://png.pngtree.com/png-clipart/20190520/original/pngtree-vector-users-icon-png-image_4144740.jpg'),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text("Jordan Ubilla"))
              ],
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Column(
                        children: [
                          Builder(builder: (BuildContext context) {
                            if (editProfile) {
                              return ProfileCardEdit();
                            } else {
                              return ProfileCardWatch();
                            }
                          }),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: FlatButton(
                              color: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  editProfile = !editProfile;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  child:
                                      Builder(builder: (BuildContext context) {
                                    if (editProfile) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(Icons.cancel)),
                                          Text('Cancelar cambios'),
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(Icons.edit)),
                                          Text('Editar perfil'),
                                        ],
                                      );
                                    }
                                  })),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width - 90,
                  buttonColor: Colors.white,
                  child: RaisedButton(
                    elevation: 1,
                    onPressed: () {
                      closeAccount();
                    },
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Cerrar cuenta',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
