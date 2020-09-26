import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactiongame_frontend/sharedFunction.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

TextEditingController email = new TextEditingController();
TextEditingController password = new TextEditingController();

GlobalKey<FormState> fromkey = GlobalKey<FormState>();

bool _obscureText = true;

Future loginUser() async {
  final String apiUrl =
      "http://192.168.100.54:3002/api/get_user/${email.text}/${password.text}";
  final response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    print(responseString);
    return responseString;
  } else {
    return null;
  }
}

void validate() async {
  if (fromkey.currentState.validate()) {
    final responseLoginUser = await loginUser();
    if (responseLoginUser != null) {
      var jsonResponse = json.decode(responseLoginUser);
      if (jsonResponse["status"] == "existed") {
        addIdUser(jsonResponse["idUser"]);
      }
      if (jsonResponse["status"] == "error-password") {}
      if (jsonResponse["status"] == "no-existed") {}
    } else {}
  } else {
    print("no validate");
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: fromkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: email,
                        validator: (val) => !EmailValidator.validate(val, true)
                            ? 'Not a valid email.'
                            : null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Email'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: password,
                              validator: (val) => val.length == 0
                                  ? 'Escriba una password'
                                  : null,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password'),
                            ),
                          ),
                          FlatButton(
                              onPressed: () => {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    })
                                  },
                              child: _obscureText
                                  ? Icon(MdiIcons.eyeOff)
                                  : Icon(MdiIcons.eye))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 90,
                        buttonColor: Colors.white,
                        child: RaisedButton(
                          elevation: 1,
                          onPressed: validate,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: const Text('Iniciar Sesion',
                                style: TextStyle(fontSize: 15)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
