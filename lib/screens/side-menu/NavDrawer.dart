import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_DashboardState.dart';

import '../../main.dart';

class NavDrawer extends StatelessWidget {
  DashboardState _dashboardState;
  JwtModel jwtModel;

  NavDrawer(DashboardState dashboardState, JwtModel jwtModel) {
    this.jwtModel = jwtModel;
    _dashboardState = dashboardState;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
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
                onTap: () => onTapLogout(context)),
          ],
        ),
      ),
    );
  }

  onTapProfile(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, ProfileRoute);
  }

  onTapMyProducts(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, MyProductsRoute, arguments: {
      "jwtModel": jwtModel});
  }

  onTapMyMessages(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, MyMessagesRoute, arguments: {
      "jwtModel": jwtModel});
  }

  onTapLogout(BuildContext context) {
    Navigator.of(context).pop();
    jwtModel.set("","");
  }
}
