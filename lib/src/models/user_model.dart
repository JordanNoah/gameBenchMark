import 'dart:convert';

UserModel userModelFromJson(String srt) => UserModel.fromJson(json.decode(srt));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String name;
  String dateBorn;
  String email;
  String password;
  String gender;
  String codeCountry;
  String country;

  UserModel(
      {this.name,
      this.dateBorn,
      this.email,
      this.password,
      this.gender,
      this.codeCountry,
      this.country});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["names"],
      dateBorn: json["bornDate"],
      email: json["email"],
      password: json["password"],
      gender: json["gender"],
      codeCountry: json["code_country"],
      country: json["country"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "dateBorn": dateBorn,
        "email": email,
        "password": password,
        "gender": gender,
        "codeCountry": codeCountry,
        "country": country
      };
}
