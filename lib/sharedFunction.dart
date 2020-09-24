import 'package:shared_preferences/shared_preferences.dart';

addIdUser(int idUser) async {
  SharedPreferences shprefe = await SharedPreferences.getInstance();
  shprefe.setInt('idUser', idUser);
}

getIdUser() async {
  SharedPreferences shprefe = await SharedPreferences.getInstance();
  int intIdUser = shprefe.getInt('idUser');
  return intIdUser;
}

removeIdUser() async {
  SharedPreferences shprefe = await SharedPreferences.getInstance();
  shprefe.remove("idUser");
}

checkIdUser() async {
  SharedPreferences shprefe = await SharedPreferences.getInstance();
  bool checkUser = shprefe.containsKey('idUser');
  return checkUser;
}
