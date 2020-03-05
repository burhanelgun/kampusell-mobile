import 'package:flutter/material.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class DashboardState extends State<DashboardScreen> {

  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: AppBarContent()
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CategoriesList(),
          ProductsList(null)
        ],
      ),


    );
  }


  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

}