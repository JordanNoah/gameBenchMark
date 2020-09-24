import 'package:flutter/material.dart';

class Conected extends StatefulWidget {
  final String namesUser;
  final String email;
  Conected({Key key, @required this.namesUser, @required this.email})
      : super(key: key);

  @override
  _ConectedState createState() => _ConectedState(this.namesUser, this.email);
}

class _ConectedState extends State<Conected> {
  String namesUser;
  String email;
  _ConectedState(this.namesUser, this.email);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(namesUser.toUpperCase()),
      onTap: () {
        Navigator.pushNamed(context, '/configAccount');
      },
      subtitle: Text(email),
      leading: CircleAvatar(
        radius: 27.0,
        backgroundImage: NetworkImage(
            'https://png.pngtree.com/png-clipart/20190520/original/pngtree-vector-users-icon-png-image_4144740.jpg'),
      ),
    );
  }
}
