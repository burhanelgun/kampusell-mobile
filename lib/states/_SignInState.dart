import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:kampusell/screens/signin/sign_in.dart';

class SignInState extends State<SignInScreen> {
  Category productCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  File _image;
  List<String> photoPaths = new List();

  SignInState();


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
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
                            controller: productNameController,
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
                            controller: productDescriptionController,
                          ),
                          SizedBox(height: 10),

                          RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                _onWillPop();
                              }
                            },
                            child: Text('Giriş Yap'),
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
}
