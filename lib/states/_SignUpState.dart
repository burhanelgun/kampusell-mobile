import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/model/signup-form.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:kampusell/screens/signin/sign_in.dart';
import 'package:kampusell/screens/signup/sign_up.dart';

import '../main.dart';

class SignUpState extends State<SignUpScreen> {
  Category productCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  File _image;
  List<String> photoPaths = new List();
  String jwt;
  SignUpState(this.jwt);


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
                titleSpacing: 0.0, title: Text("Kayıt Ol")),
            body: Builder(
              builder: (context) => Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Kullanıcı Adı'),
                            controller: usernameController,
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail'),
                            controller: emailController,
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Şifre'),
                            controller: passwordController,
                          ),
                          SizedBox(height: 10),


                          RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              _onSignUpButtonClick(context);

                            },
                            child: Text('Kayıt Ol'),
                          )


                        ])),
                  ],
                ),
              ),
            )));
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop(false);
    return false;
  }
  _onSignUpButtonClick(BuildContext context) async {
    //Initialize signup-form
    SignUpForm signUpForm = new SignUpForm(usernameController.text, emailController.text, passwordController.text);


    http.Response data;


    if(isLocal){
      data = await  http.post(
        'http://10.0.2.2:8080/api/auth/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signUpForm),
      );
    }
    else{
      data = await  http.post(
        'https://kampusell-api.herokuapp.com/api/auth/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signUpForm),
      );
    }

    print("jsonEncode:"+jsonEncode(signUpForm));
    print("------------------------------------------");
    print(data.statusCode);
    print("------------------------------------------");
    print(data.headers);
    print("------------------------------------------");
    print(data.body);
    print("------------------------------------------");

    if(data.statusCode==200){
      //signed up done. so, go the sign in page
      bool isUserSignedUp = true;
      Navigator.of(context).pop(isUserSignedUp);


    }
    else{
      //can't sign up, wait on the sign up page.
      bool isUserSignedUp = false;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Kayıt olunmadı."),
      ));
    }


  }
}
