import 'package:firebase_database/firebase_database.dart';

class Message {
  String senderUsername;
  String receiverUsername;
  String messageContent;
  String productPhotoUrl;
  String formattedDate;


  Message(this.senderUsername, this.receiverUsername, this.messageContent,this.productPhotoUrl, this.formattedDate);


  Message.fromJson(Map<String, dynamic> json) {
    this.senderUsername = json['senderUsername'].toString();
    this.receiverUsername = json['receiverUsername'].toString();
    this.messageContent = json['messageContent'].toString();
    this.productPhotoUrl = json['productPhotoUrl'].toString();
    this.formattedDate = json['formattedDate'].toString();

  }
  Message.fromSnapshot(DataSnapshot snapshot) {
    this.senderUsername = snapshot.value["senderUsername"];
    this.receiverUsername = snapshot.value["receiverUsername"];
    this.messageContent = snapshot.value["messageContent"];
    this.productPhotoUrl = snapshot.value["productPhotoUrl"];
    this.formattedDate = snapshot.value["formattedDate"];

  }
  Map<String, dynamic> toJson() => {
    'senderUsername': senderUsername,
    'receiverUsername': receiverUsername,
    'messageContent': messageContent,
    'productPhotoUrl': productPhotoUrl,
    'formattedDate': formattedDate,

  };
}
