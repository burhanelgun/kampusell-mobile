import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_DashboardState.dart';

import '../../main.dart';

class NavDrawer extends StatelessWidget {
  DashboardState _dashboardState;
  JwtModel jwtModel;
  NavDrawer(DashboardState dashboardState, JwtModel jwtModel){
    this.jwtModel=jwtModel;
    _dashboardState=dashboardState;
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/elektronik.png'))),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profilim'),
            onTap: () => onTapProfile(context),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ürünlerim'),
            onTap: () => onTapMyProducts(context),
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Mesajlarım'),
            onTap: () => onTapMyMessages(context),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış Yap'),
            onTap: () => onTapLogout(context)
          ),
        ],
      ),
    );
  }

  onTapProfile(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, ProfileRoute);
  }

  onTapMyProducts(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, MyProductsRoute);
  }

  onTapMyMessages(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, MyMessagesRoute);
  }

  onTapLogout(BuildContext context) {
    Navigator.of(context).pop();
    jwtModel.set("");

  }
}