import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/university.dart';

class SignUpForm {
  String username;
  String email;
  String password;
  String activationCode;
  University university;
  SignUpForm(this.username, this.email,this.password, this.university);

  SignUpForm.fromJson(Map<String, dynamic> json) {
    this.username = json['username'].toString();
    this.email = json['email'].toString();
    this.password = json['password'].toString();
    this.activationCode = json['activationCode'].toString();
    this.university = University.fromJson(json['university']);

  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
    'role' :["user","pm"],
    'activationCode':activationCode,
    'university':university
  };
}
