import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/providers/jwt_model.dart';

import '../../main.dart';
import 'category-item.dart';
import 'dashboard.dart';

class CategoriesList extends StatelessWidget {
  JwtModel jwtModel;
  GlobalKey<ScaffoldState> _scaffoldKey;

  CategoriesList(this.jwtModel, this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = Category.fetchAll();
    return ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 15.0,
          maxHeight: 70.0,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              CategoryItem clickedCategoryItem =
                  new CategoryItem(categories[index]);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: clickedCategoryItem,
                onTap: () => _onCategoryTap(context, clickedCategoryItem),
              );
            },
            itemCount: categories.length));
  }

  _onCategoryTap(BuildContext context, CategoryItem categoryItem) {
    //if user  signed in
    if (jwtModel.getJwt().length > 0) {
      DashboardScreen.of(context).updateProducts(categoryItem.category);
    } else {
      Navigator.pushNamed(context, SignInRoute).then((value) async {
        //read "value" value for checking is user signed in
        //after the sign in
        bool isUserSignIn = value;
        if (isUserSignIn) {
          //change default user icon with the user image in app bar
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Giriş Yapıldı"),
          ));
        } else {
          //User couldn't sign in but user can go the dashboard
        }
      });
    }
  }
}
