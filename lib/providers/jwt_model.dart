
import 'package:flutter/foundation.dart';

class JwtModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  String _jwt;


  void set(String newJwt) {
    this._jwt=newJwt;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  String getJwt() {
    return _jwt;
  }



}