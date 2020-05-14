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

  SignUpState();


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
    Navigator.of(context).pop(true);
    return false;
  }
  _onSignUpButtonClick(BuildContext context) async {
    //Initialize signup-form
    SignUpForm signUpForm = new SignUpForm(usernameController.text, emailController.text, passwordController.text);


    http.Response data;
    data = await  http.post(
      'https://kampusell-api.herokuapp.com/api/auth/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signUpForm),
    );
    print("jsonEncode:"+jsonEncode(signUpForm));
    print("------------------------------------------");
    print(data.statusCode);
    print("------------------------------------------");
    print(data.headers);
    print("------------------------------------------");
    print(data.body);
    print("------------------------------------------");

    if(data.statusCode==200){
      bool isUserSignedUp = true;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("kayıt olundu"),
      ));
    }
    else{
      bool isUserSignedUp = false;
      Navigator.of(context).pop(isUserSignedUp);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("kayıt olunamadı"),
      ));

    }

    /*//if user not signed in(for now it is false)
    bool isUserSignedUp = false;
    Navigator.of(context).pop(isUserSignedUp);

    Navigator.pushNamed(context, SignUpRoute).then((value) {
      //read "value" value for checking is user signed up
      value=true;
      isUserSignedUp=value;
      //after the sign in
      if(isUserSignedUp==true){
        //if user signed up successfully, then do nothing
      }
      else{
        //if user cannot signed up successfully,then pop the sign in page with false
        Navigator.of(context).pop(false);
        //false causes showing dashboard in app-barr-content.dart

      }
    });
*/
  }
}
