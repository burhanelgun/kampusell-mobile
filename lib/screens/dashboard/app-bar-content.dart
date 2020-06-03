import 'package:flutter/material.dart';
import 'package:kampusell/main.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_DashboardState.dart';

class AppBarContent extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _searchTextController;
  DashboardState _dashboardState;
  JwtModel _jwtModel;

  AppBarContent(
      GlobalKey<ScaffoldState> scaffoldKey,
      TextEditingController searchTextController,
      DashboardState dashboardState,
      JwtModel jwtModel) {
    _scaffoldKey = scaffoldKey;
    _searchTextController = searchTextController;
    _dashboardState = dashboardState;
    _jwtModel = jwtModel;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () => handleAccountClick(context),
        ),
        Flexible(
            child: TextField(
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hoverColor: Colors.white,
              focusColor: Colors.white,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(25.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 32.0),
                  borderRadius: BorderRadius.circular(25.0)),
              hintText: 'Ürün Ara'),
          controller: _searchTextController,
          onSubmitted: _onSearchTextSubmitted(),
          onChanged: _onSearchTextChanged(),
          onEditingComplete: () => _onSearchTextEditingComplete(),
        )),
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _onSellProductBtnClick(context)),
      ],
    );
  }

  _onSellProductBtnClick(BuildContext context) async {
    //if user  signed in
    if (_jwtModel.getJwt().length > 0) {
      final productFilter =
          await Navigator.pushNamed(context, FilterSettingsRoute);
      _dashboardState.filter(productFilter);
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
          final productFilter =
              await Navigator.pushNamed(context, FilterSettingsRoute);
          _dashboardState.filter(productFilter);
        } else {
          //User couldn't sign in but user can go the dashboard
        }
      });
    }
  }

  _onSearchTextEditingComplete() {
    _dashboardState.search();

    //print("onsearchtexteditingcomplete");
  }

  _onSearchTextSubmitted() {
    //print("onsubmitted");
  }

  _onSearchTextChanged() {
    // print("onchanged");
  }

  handleAccountClick(BuildContext context) {
    //if user  signed in
    if (_jwtModel.getJwt().length > 0) {
      _scaffoldKey.currentState.openDrawer();
    } else {
      Navigator.pushNamed(context, SignInRoute).then((value) {
        //read "value" value for checking is user signed in
        //after the sign in
        bool isUserSignIn = value;
        if (isUserSignIn) {
          //change default user icon with the user image in app bar
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Giriş Yapıldı"),
          ));
          _dashboardState.updateProductsDefault();
        } else {
          //User couldn't sign in but user can go the dashboard
        }
      });
    }
  }
}
