import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/signup-form.dart';
import 'package:kampusell/model/university.dart';
import 'package:kampusell/screens/signup/sign_up.dart';

import '../main.dart';

class SignUpState extends State<SignUpScreen> {
  Category productCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
  final usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController universityController = TextEditingController(text: "@");
  final passwordController = TextEditingController();
  List<University> universities = new List<University>();
  University selectedUniversity = null;

  File _image;
  List<String> photoPaths = new List();

  SignUpState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUniversities();
  }

  Future<String> getUniversities() async {
    http.Response response;
    if (isLocal) {
      response = await http.get(
        "http://10.0.2.2:8080/api/auth/universities",
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.get(
        "https://kampusell-api.herokuapp.com/api/auth/universities",
        headers: {'Content-Type': 'application/json'},
      );
    }
    List<dynamic> jsonData = json.decode(utf8.decode(response.bodyBytes));
    List<University> universitiesLocal = [];
    for (int i = 0; i < jsonData.length; i++) {
      University university = new University(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['email'].toString(),
      );
      universitiesLocal.add(university);
    }

    setState(() {
      this.universities = universitiesLocal;
    });
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(titleSpacing: 0.0, title: Text("Kayıt Ol")),
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
                          Row(
                            children: <Widget>[
                              Expanded(
                                child:   TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Lütfen bir değer giriniz';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'E-mail'),
                                  controller: emailController,
                                ) ,
                              ),
                              Expanded(
                                child:   TextFormField(
                                  enabled: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Lütfen bir değer giriniz';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                     ),
                                  controller: universityController,
                                ) ,
                              )


                            ],
                          ),

                          SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
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
                          DropdownButtonFormField<University>(
                            value: selectedUniversity != null
                                ? selectedUniversity
                                : null,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            hint: Text("Okul Seçiniz"),
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (University newUniversity) {
                              setState(() {
                                selectedUniversity = newUniversity;
                                universityController..text = "@"+selectedUniversity.email;
                              });
                            },
                            items: universities
                                .map<DropdownMenuItem<University>>(
                                    (University university) {
                              return DropdownMenuItem<University>(
                                value: university,
                                child: Text(university.name),
                              );
                            }).toList(),
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
    print("emailController.text+universityController.text:"+emailController.text+universityController.text);
    SignUpForm signUpForm = new SignUpForm(usernameController.text,
        emailController.text+universityController.text, passwordController.text, selectedUniversity);

    http.Response data;

    if (isLocal) {
      data = await http.post(
        'http://10.0.2.2:8080/api/auth/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signUpForm),
      );
    } else {
      data = await http.post(
        'https://kampusell-api.herokuapp.com/api/auth/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(signUpForm),
      );
    }

    if (data.statusCode == 200) {
      //half signed up done. so, go the activation  page
      bool isUserSignedUpHalf = true;
      String activationCode = json.decode(data.body)["message"].toString();
      Navigator.pushNamed(context, ActivationRoute, arguments: {
        "signUpForm": signUpForm,
        "activationCode": activationCode
      }).then((value) {
        //read "value" value for checking is user signed up
        print("value:" + value.toString());
        bool isUserActivated = value;
        if (isUserActivated == true) {
          //User could activate the code so user signed up successfully, then wait in sign in page
          Navigator.of(context).pop(true);
        } else {
          //user couldn't activate the code, wait on the page, don't do automatic process
          bool isUserSignedUp = false;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Aktivasyon Kodu Doğrulanmadı"),
          ));
        }
      });

      //Navigator.of(context).pop(isUserSignedUp);

    } else {
      //can't sign up, wait on the sign up page.
      bool isUserSignedUp = false;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Kayıt olunmadı."),
      ));
    }
  }
}
