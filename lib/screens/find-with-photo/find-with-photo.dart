import 'package:flutter/material.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';
import 'package:kampusell/states/_FindWithPhotoState.dart';

class FindWithPhotoScreen extends StatefulWidget {
  static FindWithPhotoState of(BuildContext context) =>
      context.findAncestorStateOfType();

  FindWithPhotoScreen();

  @override
  FindWithPhotoState createState() => FindWithPhotoState();
}
