import 'dart:convert';

List<SignInModel> zoneFromJson(String str) =>
    List<SignInModel>.from(
        json.decode(str).map((x) => SignInModel.fromJson(x)));

String zoneToJson(List<SignInModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SignInModel {
  String? emailAddress;
  String ? password;

  SignInModel({
    this.emailAddress,
    this.password,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      emailAddress: json['emailAddress'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'password': password
    };
  }
}
