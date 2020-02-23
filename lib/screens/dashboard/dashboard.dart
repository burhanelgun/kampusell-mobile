


import 'package:flutter/material.dart';
import 'package:kampusell/screens/dashboard/AppBarContent.dart';

class CustomAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: AppBarContent()
      ),


    );
  }

}