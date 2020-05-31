import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/signup-form.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';
import 'package:kampusell/states/_ActivationState.dart';

class ActivationScreen extends StatefulWidget {
  JwtModel jwtModel;
  SignUpForm signUpForm;
  ActivationScreen(this.jwtModel, this.signUpForm);

  static ActivationState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  ActivationState createState() => ActivationState(jwtModel,signUpForm);
}
