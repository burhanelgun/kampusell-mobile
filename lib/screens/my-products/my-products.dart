import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProductsScreen extends StatelessWidget {
  String jwt;
  MyProductsScreen(this.jwt);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0.0, title: Text("My Products")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text("merhbalar"),
          Text("merhbalar"),

        ],
      ),
    );
  }
}
