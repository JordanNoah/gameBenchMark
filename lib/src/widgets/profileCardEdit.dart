import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:reactiongame_frontend/sharedFunction.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reactiongame_frontend/src/models/user_model.dart';
import 'package:http/http.dart' as http;

class ProfileCardEdit extends StatefulWidget {
  ProfileCardEdit({Key key}) : super(key: key);

  @override
  _ProfileCardEditState createState() => _ProfileCardEditState();
}

DateTime selectedDate;

String idUser;
TextEditingController name = new TextEditingController();
TextEditingController dateBorn = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController password = new TextEditingController();
String gender;
String country;

int idGender;

GlobalKey<FormState> fromkey = GlobalKey<FormState>();

class Item {
  const Item(this.names, this.icon);
  final String names;
  final Icon icon;
}

class _ProfileCardEditState extends State<ProfileCardEdit> {
  Future buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateFormat('dd/MM/yyyy').parse(dateBorn.text),
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        dateBorn.text = formatter.format(picked).toString();
      });
    }
  }

  List users = [
    const Item(
        'Male',
        Icon(
          MdiIcons.humanMale,
          color: Colors.black,
        )),
    const Item(
        'Female',
        Icon(
          MdiIcons.humanFemale,
          color: Colors.black,
        )),
    const Item(
        'Others',
        Icon(
          MdiIcons.accountQuestion,
          color: Colors.black,
        )),
  ];

  Future getUserById() async {
    var userId = await getIdUser();
    final String apiUrl = "http://192.168.100.54:3002/api/get_user_id/$userId";
    final response = await http.get(apiUrl);
    var jsonResonse = json.decode(response.body)["user"];
    var users = userModelFromJson(json.encode(jsonResonse));
    var formatter = DateFormat('dd/MM/yyyy').parse(users.dateBorn);

    final DateFormat format = DateFormat('dd/MM/yyyy');

    this.users.asMap().forEach((key, value) {
      if (value.names == users.gender) {
        idGender = key;
      }
    });

    idUser = jsonResonse["user_id"].toString();
    name.text = users.name;
    dateBorn.text = format.format(formatter).toString();
    email.text = users.email;
    password.text = users.password;
    gender = users.gender;
    country = users.country;
  }

  Future changeUser() async {
    final String apiUrl = "http://192.168.100.54:3002/api/save_modification";
    final response = await http.post(apiUrl, body: {
      "idUser": idUser,
      "name": name.text,
      "dateBorn": dateBorn.text,
      "email": email.text,
      "password": password.text,
      "gender": gender,
      "country": country
    });
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    getUserById();
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: name,
              validator: (val) =>
                  val.length == 0 ? 'Ingrese un nombre valido' : null,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Nombre'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              readOnly: true,
              validator: (val) => val.length == 0 ? 'Escoja una fecha' : null,
              onTap: () => buildMaterialDatePicker(context),
              controller: dateBorn,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Date of birth'),
            ),
          ),
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
                    validator: (val) =>
                        val.length == 0 ? 'Escriba una password' : null,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password'),
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
              child: Row(
                children: [
                  Text("Gender"),
                  SizedBox(width: 50.0),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: users[idGender],
                      validator: (val) =>
                          val == null ? 'Escoja un genero' : null,
                      isExpanded: true,
                      items: users.map((user) {
                        return DropdownMenuItem(
                          value: user,
                          child: Row(
                            children: [
                              user.icon,
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                user.names,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          gender = value.names;
                        });
                      },
                    ),
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(child: Text("Country")),
                  CountryListPick(
                    appBarBackgroundColor: Colors.amber,
                    isShowFlag: true,
                    isShowTitle: true,
                    isShowCode: true,
                    isDownIcon: true,
                    showEnglishName: true,
                    onChanged: (CountryCode code) {
                      country = code.name;
                    },
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                changeUser();
              },
              child: Text(
                "Change account",
              ),
            ),
          )
        ],
      ),
    );
  }
}
