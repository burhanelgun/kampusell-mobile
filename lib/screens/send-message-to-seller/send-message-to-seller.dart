import 'package:flutter/material.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';
import 'package:kampusell/states/_SendMessageToSellerState.dart';

class SendMessageToSellerScreen extends StatefulWidget {
  String username;
  static SendMessageToSellerState of(BuildContext context) =>
      context.findAncestorStateOfType();

  SendMessageToSellerScreen(this.username);

  @override
  SendMessageToSellerState createState() => SendMessageToSellerState(username);
}
