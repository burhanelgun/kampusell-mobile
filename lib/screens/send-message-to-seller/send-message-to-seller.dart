import 'package:flutter/material.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';
import 'package:kampusell/states/_SendMessageToSellerState.dart';

class SendMessageToSellerScreen extends StatefulWidget {
  static SendMessageToSellerState of(BuildContext context) =>
      context.findAncestorStateOfType();

  SendMessageToSellerScreen();

  @override
  SendMessageToSellerState createState() => SendMessageToSellerState();
}
