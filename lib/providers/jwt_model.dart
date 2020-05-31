
import 'package:flutter/foundation.dart';

import '../main.dart';

class JwtModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  String _jwt;

  JwtModel(){
    read();
  }
  void read() async {
    var jwt = await storage.read(key: "jwt");
    print("jwt readden şunu okudu:"+jwt.toString()+"..");
    if(jwt == null){
      _jwt="";
    }
    else{
      _jwt=jwt;
    }
    notifyListeners();
  }

  Future<String> write(String jwt)  {
    storage.delete(key:"jwt");
    storage.write(key: "jwt", value: jwt);
    _jwt=jwt;
    notifyListeners();
  }

  void set(String newJwt) {
    this._jwt=newJwt;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  String getJwt() {
    return _jwt;
  }



}