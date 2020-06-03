import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusell/model/signup-form.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/activation/activation.dart';

import '../main.dart';

class ActivationState extends State<ActivationScreen>
    with TickerProviderStateMixin {
  final activationCodeTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AnimationController controller;
  String activationCode;
  JwtModel jwtModel;

  SignUpForm signUpForm;

  ActivationState(this.jwtModel, this.signUpForm, this.activationCode);

  @override
  Future<void> initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 45),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);

    controller.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.dismissed) {
        //delete user and navigate to sign up page
        await deleteUser();
        Navigator.of(context).pop(false);
      }
    });
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0.0, title: Text("Hesabını Aktive Et")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Text(timerString);
            },
          ),
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
                      labelText: 'Aktivasyon Kodu'),
                  controller: activationCodeTextController,
                ),
                SizedBox(height: 10),

                RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      _onActivateButtonClick(context);
                    }
                  },
                  child: Text('Aktive Et'),
                )
              ])),
        ],
      ),
    );
  }

  void _onActivateButtonClick(BuildContext context) {
    bool isRegistrationIsActivated = true;

    if (activationCodeTextController.text == activationCode) {
      controller.dispose();
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
    }
  }

  Future<http.Response> deleteUser() {
    signUpForm.activationCode = this.activationCode;
    if (isLocal) {
      return http.post(
        'http://10.0.2.2:8080/api/auth/deleteUser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(signUpForm),
      );
    } else {
      return http.post(
        'https://kampusell-api.herokuapp.com/api/auth/deleteUser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(signUpForm),
      );
    }
  }
}
