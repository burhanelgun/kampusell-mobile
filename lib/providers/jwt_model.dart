
import 'package:flutter/foundation.dart';

class JwtModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  String jwt;




  void add(String newJwt) {
    this.jwt=newJwt;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    jwt="";
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}