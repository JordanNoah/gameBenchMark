import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:email_validator/email_validator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

DateTime selectedDate = DateTime.now();
final DateFormat formatter = DateFormat('dd/MM/yyyy');

TextEditingController name = new TextEditingController();
TextEditingController dateBorn = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController password = new TextEditingController();
String gender;
String country;

GlobalKey<FormState> fromkey = GlobalKey<FormState>();

class Item {
  const Item(this.names, this.icon);
  final String names;
  final Icon icon;
}

Future createUser() async {
  final String apiUrl = "http://192.168.100.54:3002/api/create_user";

  final response = await http.post(apiUrl, body: {
    "name": name.text,
    "dateBorn": dateBorn.text,
    "email": email.text,
    "password": password.text,
    "gender": gender,
    "country": country
  });
  if (response.statusCode == 200) {
    final String responseString = response.body;

    return (responseString);
  } else {
    return null;
  }
}

void validate() async {
  if (fromkey.currentState.validate()) {
    final responseCreateUser = await createUser();
    print(responseCreateUser);
  } else {
    print("no validate");
  }
}

class _RegisterState extends State<Register> {
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
        dateBorn.text = formatter.format(selectedDate).toString();
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

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Created an account!!"),
          centerTitle: true,
          elevation: 0,
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
                          controller: name,
                          validator: (val) => val.length == 0
                              ? 'Ingrese un nombre valido'
                              : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nombre'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          readOnly: true,
                          validator: (val) =>
                              val.length == 0 ? 'Escoja una fecha' : null,
                          onTap: () => buildMaterialDatePicker(context),
                          controller: dateBorn,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Date of birth'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: email,
                          validator: (val) =>
                              !EmailValidator.validate(val, true)
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
                          child: Row(
                            children: [
                              Text("Gender"),
                              SizedBox(width: 50.0),
                              Expanded(
                                child: DropdownButtonFormField(
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    print(value.names);
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
                                buttonColor: Colors.black12,
                                isDownIcon: true,
                                isShowCode: false,
                                isShowFlag: true,
                                isShowTitle: true,
                                showEnglishName: true,
                                onChanged: (CountryCode code) {
                                  setState(() {
                                    country = code.name;
                                  });
                                },
                              )
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
                          onPressed: validate,
                          child: Text(
                            "Create account",
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
