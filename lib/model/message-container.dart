import 'package:firebase_database/firebase_database.dart';
import 'package:kampusell/model/product.dart';

class MessageContainer {
  String productId;
  String otherUsername;
  String lastMessage;
  MessageContainer(this.productId,this.otherUsername,this.lastMessage);

}
