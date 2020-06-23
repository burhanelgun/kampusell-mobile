import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/send-message-to-seller/message-item.dart';
import 'package:kampusell/screens/send-message-to-seller/send-message-to-seller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kampusell/model/product.dart';

class SendMessageToSellerState extends State<SendMessageToSellerScreen> {
  JwtModel _jwtModel;
  Product _product;
  int c =0;
  SendMessageToSellerState(this._jwtModel,this._product);

  final _formKey = GlobalKey<FormState>();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();
  DatabaseReference messagesReference;
  DatabaseReference privMessagesReferenceMe;
  DatabaseReference privMessagesReferenceOther;

  List<Message> messages = new List<Message>();


  @override
  void initState() {
    super.initState();
    //messages = Message.fetchAll();
    messagesReference = FirebaseDatabase.instance.reference().child("messages");

    privMessagesReferenceMe = messagesReference.child(_product.student.username).child(_jwtModel.getUsername()).child(_product.id);
    privMessagesReferenceOther = messagesReference.child(_jwtModel.getUsername()).child(_product.student.username).child(_product.id);

    privMessagesReferenceMe.onChildAdded.listen(_onNewMessageSent);


  }
  _onNewMessageSent(Event event) {
      setState(() {
        Message m= Message.fromSnapshot(event.snapshot);
        print("buyuk:"+ m.messageContent);
        messages.add(m);

      });

  }



  @override
  Widget build(BuildContext context) {
    if (messages == null) {
      Scaffold(
          appBar: new AppBar(
            titleSpacing: 0.0,
            title: Text("Mesaj Gönder"),
          ),
          body: Container(
            child: Center(
              child: Text("Loading..."),
            ),
          ));
    } else {
      return Scaffold(
          appBar: new AppBar(
            titleSpacing: 0.0,
            title: Text("Mesaj Gönder"),
          ),
          body: Container(
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.red,
                    child: ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        MessageItem messageItem = new MessageItem(messages[messages.length - index - 1],_jwtModel.getUsername());

                        return messageItem;
                      },
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a search term'
                  ),
                  controller: messageTextController,
                  onSubmitted: _onSearchTextSubmitted(),
                  onChanged: _onSearchTextChanged(),
                  onEditingComplete: () => _onSearchTextEditingComplete(),

                )
              ],
            ),
          )
      );
    }
  }


  _onSearchTextEditingComplete() {
    print(_jwtModel.getUsername());
    print("onsearchtexteditingcomplete");
    print("text:"+ messageTextController.text);
    setState(() {
      //need to locally stored for no internet connection
        Message m = new Message(_jwtModel.getUsername(), _product.student.username, messageTextController.text);
        //messages.add(m);
        privMessagesReferenceMe.push().set(m.toJson());
        privMessagesReferenceOther.push().set(m.toJson());

    });
    messageTextController.clear();

  }

  _onSearchTextSubmitted() {
    print("onsubmitted");
    print("text:"+ messageTextController.text);

  }

  _onSearchTextChanged() {
    print("onchanged");
    print("text:"+ messageTextController.text);

  }

}



