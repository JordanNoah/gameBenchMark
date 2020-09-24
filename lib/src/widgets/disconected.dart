import 'package:flutter/material.dart';

class Disconected extends StatefulWidget {
  Disconected({Key key}) : super(key: key);

  @override
  _DisconectedState createState() => _DisconectedState();
}

class _DisconectedState extends State<Disconected> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Sin conecctar"),
      onTap: () => {Navigator.pushNamed(context, '/homeLogRegister')},
      leading: CircleAvatar(
        radius: 27.0,
        backgroundImage: NetworkImage(
            'https://png.pngtree.com/png-clipart/20190520/original/pngtree-vector-users-icon-png-image_4144740.jpg'),
      ),
    );
  }
}
