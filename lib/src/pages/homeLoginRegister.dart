import 'package:flutter/material.dart';

class HomeLoginRegister extends StatefulWidget {
  HomeLoginRegister({Key key}) : super(key: key);

  @override
  _HomeLoginRegisterState createState() => _HomeLoginRegisterState();
}

class _HomeLoginRegisterState extends State<HomeLoginRegister> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Inicia sesión o create una cuenta",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Posee una cuenta gratis para guardar tus scores y acceder a ellos desde otros dispositivos y compararlos con los demas jugadores",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black38),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width - 90,
              buttonColor: Colors.white,
              child: RaisedButton(
                elevation: 1,
                onPressed: () {
                  Navigator.pushNamed(context, "/register");
                },
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Crear cuenta',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width - 90,
              buttonColor: Colors.white,
              child: RaisedButton(
                elevation: 1,
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Iniciar Sesion',
                      style: TextStyle(fontSize: 15)),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
