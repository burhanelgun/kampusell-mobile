import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/signup-form.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_ActivationState.dart';

class ActivationScreen extends StatefulWidget {
  JwtModel jwtModel;
  SignUpForm signUpForm;
  String activationCode;

  ActivationScreen(this.jwtModel, this.signUpForm, this.activationCode);

  static ActivationState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  ActivationState createState() =>
      ActivationState(jwtModel, signUpForm, activationCode);
}
