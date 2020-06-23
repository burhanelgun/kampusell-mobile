import 'package:firebase_database/firebase_database.dart';

class Message {
  String senderUsername;
  String receiverUsername;
  String messageContent;


  Message(this.senderUsername, this.receiverUsername, this.messageContent);

  static List<Message> fetchAll() {
    return [
      Message('elgunburhan', 'genctrkn', "merhaba"),
      Message('elgunburhan', 'genctrkn', "nasilsin"),
      Message('genctrkn', 'elgunburhan', "iyiyim"),
      Message('genctrkn', 'elgunburhan', "sen nasilsin"),
      Message('elgunburhan', 'genctrkn', "ben de iyiyim"),
    ];
  }

  Message.fromJson(Map<String, dynamic> json) {
    this.senderUsername = json['senderUsername'].toString();
    this.receiverUsername = json['receiverUsername'].toString();
    this.messageContent = json['messageContent'].toString();

  }
  Message.fromSnapshot(DataSnapshot snapshot) {
    this.senderUsername = snapshot.value["senderUsername"];
    this.receiverUsername = snapshot.value["receiverUsername"];
    this.messageContent = snapshot.value["messageContent"];

  }
  Map<String, dynamic> toJson() => {
    'senderUsername': senderUsername,
    'receiverUsername': receiverUsername,
    'messageContent': messageContent,
  };
}
