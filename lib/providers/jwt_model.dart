import 'package:flutter/foundation.dart';

import '../main.dart';

class JwtModel extends ChangeNotifier {
  String _jwt;
  String _username;

  JwtModel() {
    read();
  }

  void read() async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) {
      _jwt = "";
    } else {
      _jwt = jwt;
      var username = await storage.read(key: "username");
      _username = username;
    }
    notifyListeners();
  }

  void set(String newJwt,String newUsername) {
    this._jwt = newJwt;
    this._username=newUsername;
    storage.delete(key: "jwt");
    storage.delete(key: "username");
    storage.write(key: "jwt", value: newJwt);
    print("deneme2:"+_username);
    storage.write(key: "username", value: newUsername);

    notifyListeners();
  }

  String getJwt() {
    return _jwt;
  }

  String getUsername() {
    return _username;
  }
}
