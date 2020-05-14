import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/model/signin-form.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:kampusell/screens/signin/sign_in.dart';

import '../main.dart';

class SignInState extends State<SignInScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Category productCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  File _image;
  List<String> photoPaths = new List();

  SignInState();


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                titleSpacing: 0.0, title: Text("Giriş Yap")),
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
                          // Add TextFormFields and RaisedButton here.
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
                                labelText: 'Şifre'),
                            controller: passwordController,
                          ),
                          SizedBox(height: 10),

                          RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                _onSignInButtonClick();
                              }
                            },
                            child: Text('Giriş Yap'),
                          ),
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
  _onSignUpButtonClick(BuildContext context) {
    //if user not signed in(for now it is false)
    bool isUserSignedUp = false;
    Navigator.of(context).pop(isUserSignedUp);

    Navigator.pushNamed(context, SignUpRoute).then((value) {
      //read "value" value for checking is user signed up
      isUserSignedUp=value;
      //after the sign up
      if(isUserSignedUp==true){
        print("kayıt olunmuş");

        //if user signed up successfully, then wait in sign in page
      }
      else{
        print("kayıt olunamamış");

        //if user cannot signed up successfully,then pop the sign in page with false
        Navigator.of(context).pop(false);
        //false causes showing dashboard in app-barr-content.dart

      }
    });

  }

  Future<void> _onSignInButtonClick() async {
    //Initialize signin form object

    SignInForm signInForm = new SignInForm(usernameController.text, passwordController.text);


    http.Response data;
    data = await  http.post(
      'https://kampusell-api.herokuapp.com/api/auth/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signInForm),
    );
    print("jsonEncodee:"+jsonEncode(signInForm));
    print("e------------------------------------------");
    print(data.statusCode);
    print("e------------------------------------------");
    print(data.headers);
    print("e------------------------------------------");
    print(data.body);
    print("e------------------------------------------");

    if(data.statusCode==200){
      bool isUserSignedUp = true;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("giriş yapıldı"),
      ));
    }
    else{
      bool isUserSignedUp = false;
      Navigator.of(context).pop(isUserSignedUp);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("giriş yapılamadı"),
      ));

    }


  }

}

