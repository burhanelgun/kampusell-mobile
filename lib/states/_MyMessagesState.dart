import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message-container.dart';
import 'package:kampusell/model/message.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/my-messages/message-container-item.dart';
import 'package:kampusell/screens/my-messages/my-messages.dart';
import 'package:firebase_database/firebase_database.dart';

class MyMessagesState extends State<MyMessagesScreen> {


  JwtModel jwtModel;
  List<MessageContainer> messageContainers=new List<MessageContainer>();

  MyMessagesState(this.jwtModel);
  DatabaseReference messagesReference;


  @override
  void initState() {
    super.initState();
    //messages = Message.fetchAll();
    messagesReference = FirebaseDatabase.instance.reference().child("messages").child(jwtModel.getUsername());

      messagesReference.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key1, values1) {
          String otherUsername = key1;
          print("otherUsername:" + otherUsername);

          Map<dynamic, dynamic> values2 = values1;
          values2.forEach((key3, values3) {
            String productId = key3;
            print("productId:" + productId);
            String lastMessageContent;
            values3.forEach((key4, values5) {
              String hashedKeyOfSingleMessage = key4;

              String senderUsername = values5["senderUsername"];
              String receiverUsername = values5["receiverUsername"];
              String messageContent = values5["messageContent"];
              lastMessageContent = messageContent;
            });
            print("lastMessageContent:" + lastMessageContent);
            MessageContainer messageContainer = new MessageContainer(
                productId, otherUsername, lastMessageContent,
                messagesReference.child(otherUsername).child(productId));

            print(messageContainer.messagesReference.path);
            messageContainer.messagesReference.onChildAdded.listen((
                Event event) {
              print("event.snapshot:"+event.snapshot.value.toString());

              print("listener calisti:"+messageContainer.productId);




            });
            setState(() {
              messageContainers.add(messageContainer);
            });
          });
        });
      });


      //messagesReference.onChildChanged.listen(_onNewMessageSent);


  }
  _onNewMessageSent(Event event) {
    //print("listenerrrrrrr");
    setState(() {
      //print("event.snapshot:"+event.snapshot.value.toString());
      //Message m= Message.fromSnapshot(event.snapshot);
      //print("buyuk:"+ m.messageContent);

    });

  }

  @override
  Widget build(BuildContext context) {
    if (messageContainers.length==0) {
      return Scaffold(
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
          body:  Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.red,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: messageContainers.length,
                      itemBuilder: (context, index) {
                        print("messageContainers["+index.toString()+"].productId:"+messageContainers[index].productId);
                        print("messageContainers["+index.toString()+"].otherUsername:"+messageContainers[index].otherUsername);
                        print("messageContainers["+index.toString()+"].lastMessage:"+messageContainers[index].lastMessage);
                        print("messageContainers.lenght:"+ messageContainers.length.toString());
                        MessageContainerItem messageContainerItem = new MessageContainerItem(messageContainers[index],jwtModel);

                        return messageContainerItem;
                      },
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a search term'
                  ),


                )
              ],
            ),

      );
    }
  }


}