import 'package:flutter/foundation.dart';

import '../main.dart';

class JwtModel extends ChangeNotifier {
  String _jwt;

  JwtModel() {
    read();
  }

  void read() async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) {
      _jwt = "";
    } else {
      _jwt = jwt;
    }
    notifyListeners();
  }

  void set(String newJwt) {
    this._jwt = newJwt;
    storage.delete(key: "jwt");
    storage.write(key: "jwt", value: newJwt);
    notifyListeners();
  }

  String getJwt() {
    return _jwt;
  }
}
