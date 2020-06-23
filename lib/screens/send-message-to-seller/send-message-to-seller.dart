import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';
import 'package:kampusell/states/_SendMessageToSellerState.dart';

class SendMessageToSellerScreen extends StatefulWidget {
  JwtModel _jwtModel;
  static SendMessageToSellerState of(BuildContext context) =>
      context.findAncestorStateOfType();

  SendMessageToSellerScreen(this._jwtModel);

  @override
  SendMessageToSellerState createState() => SendMessageToSellerState(_jwtModel);
}
