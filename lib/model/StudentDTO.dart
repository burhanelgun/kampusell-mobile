import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/university.dart';

class StudentDTO {
  String username;
  String email;
  String universityName;
  StudentDTO(this.username, this.email, this.universityName);

  StudentDTO.fromJson(Map<String, dynamic> json) {
    this.username = json['username'].toString();
    this.email = json['email'].toString();
    this.universityName = json['universityName'].toString();


  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'universityName': universityName,
  };
}
