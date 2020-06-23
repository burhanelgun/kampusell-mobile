import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/signin-form.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/signin/sign_in.dart';
import 'package:provider/provider.dart';

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
            appBar: AppBar(titleSpacing: 0.0, title: Text("Giriş Yap")),
            body: Builder(
              builder: (context) => Container(
                margin: EdgeInsets.all(20),
                child:
                    Consumer<JwtModel>(builder: (context, jwtProvider, child) {
                  return Column(
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
                                  return 'Lütfen bir değer giriniz';
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
                                  return 'Lütfen bir değer giriniz';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Şifre'),
                              controller: passwordController,
                            ),
                            SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: Material(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.pink,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState.validate()) {
                                        _onSignInButtonClick(jwtProvider);

                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Giriş Yap',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: Material(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.pink,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                        _onSignUpButtonClick(context);

                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Kayıt Ol',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            )
                          ])),
                    ],
                  );
                }),
              ),
            )));
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop({"isSignIn": false});
    return false;
  }

  _onSignUpButtonClick(BuildContext context) {
    //if user not signed in(for now it is false)

    Navigator.pushNamed(context, SignUpRoute).then((value) {
      //read "value" value for checking is user signed up
      bool isUserSignedUp = value;
      if (isUserSignedUp == true) {
        //User could sign up
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Kayıt olundu."),
        ));
        //if user signed up successfully, then wait in sign in page
      } else {
        //user couldn't sign up, wait on the page, don't do automatic process

      }
    });
    // Navigator.pushNamed(context, ActivationRoute);
  }

  Future<void> _onSignInButtonClick(JwtModel jwtProvider) async {
    //Initialize signin form object
    //'http://10.0.2.2:8080/api/products/s',

    SignInForm signInForm =
        new SignInForm(usernameController.text, passwordController.text);

    http.Response data;
    if (isLocal) {
      data = await http.post(
        'http://10.0.2.2:8080/api/auth/signin',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signInForm),
      );
    } else {
      data = await http.post(
        'https://kampusell-api.herokuapp.com/api/auth/signin',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signInForm),
      );
    }

    Map<String, dynamic> jsonData = json.decode(data.body);

    if (data.statusCode == 200) {
      bool isUserSignedIn = true;
      String localJwt = jsonData["tokenType"].toString() +
          " " +
          jsonData["accessToken"].toString();

      jwtProvider.set(localJwt);
      Navigator.of(context).pop({"isSignIn": true, "signInForm":signInForm});
    } else {
      bool isUserSignedUp = false;
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Giriş yapılamadı."),
      ));
    }
  }
}
