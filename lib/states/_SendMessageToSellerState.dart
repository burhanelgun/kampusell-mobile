import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/send-message-to-seller/message-item.dart';
import 'package:kampusell/screens/send-message-to-seller/send-message-to-seller.dart';

class SendMessageToSellerState extends State<SendMessageToSellerScreen> {
  SendMessageToSellerState();

  final _formKey = GlobalKey<FormState>();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();

  List<Message> messages = List();

  @override
  void initState() {
    super.initState();
    messages = Message.fetchAll();
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
                        MessageItem messageItem = new MessageItem(messages[messages.length - index - 1]);

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

    print("onsearchtexteditingcomplete");
    print("text:"+ messageTextController.text);
    setState(() {
      messages.add(new Message(messageTextController.text, messageTextController.text, messageTextController.text));
    });


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


