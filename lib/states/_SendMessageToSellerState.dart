import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message-container.dart';
import 'package:kampusell/model/message.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/send-message-to-seller/message-item.dart';
import 'package:kampusell/screens/send-message-to-seller/send-message-to-seller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kampusell/model/product.dart';
import 'package:intl/intl.dart';

class SendMessageToSellerState extends State<SendMessageToSellerScreen> {
  JwtModel _jwtModel;
  MessageContainer messageContainer;
  int c =0;
  SendMessageToSellerState(this._jwtModel,this.messageContainer);

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
    privMessagesReferenceMe = messagesReference.child(messageContainer.otherUsername).child(_jwtModel.getUsername()).child(messageContainer.productId);
    privMessagesReferenceOther = messagesReference.child(_jwtModel.getUsername()).child(messageContainer.otherUsername).child(messageContainer.productId);

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
              child: Text("Yükleniyor..."),
            ),
          ));
    } else {
      return Scaffold(
          appBar: new AppBar(
            titleSpacing: 0.0,
            title: Text("Mesaj Gönder"),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
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
               /* TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a search term'
                  ),
                  controller: messageTextController,
                  onSubmitted: _onSearchTextSubmitted(),
                  onChanged: _onSearchTextChanged(),
                  onEditingComplete: () => _onSearchTextEditingComplete(),

                )*/
                Container(
                  margin: EdgeInsets.all(15.0),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35.0),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "Bir mesaj yaz",
                                        border: InputBorder.none),
                                    controller: messageTextController,
                                    onSubmitted: _onSearchTextSubmitted(),
                                    onChanged: _onSearchTextChanged(),
                                    onEditingComplete: () => _onSearchTextEditingComplete(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
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
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('kk:mm').format(now);
        Message m = new Message(_jwtModel.getUsername(),messageContainer.otherUsername, messageTextController.text,messageContainer.productPhotoUrl,formattedDate);

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



