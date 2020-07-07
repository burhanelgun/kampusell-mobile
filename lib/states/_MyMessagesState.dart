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
          DatabaseReference existedOtherUserReference =messagesReference.child(otherUsername) ;

          existedOtherUserReference.onChildAdded.listen((
              Event event) {
            print("1111111111111");



            Map<dynamic, dynamic> values = event.snapshot.value;
            values.forEach((key, values1) {
              String productId =  event.snapshot.key.toString();
              MessageContainer messageContainer = new MessageContainer(
                  productId, otherUsername, values1["messageContent"],
                  messagesReference.child(otherUsername).child(productId),values1["productPhotoUrl"]);
              print(messageContainer.otherUsername);
              print(messageContainer.lastMessage);
              print(messageContainer.productId);


              setState(() {
                int flag=0;
                for(int i = 0;i <messageContainers.length;i++){
                  if(messageContainers[i].productId == messageContainer.productId &&
                      messageContainers[i].otherUsername==messageContainer.otherUsername){
                      flag=1;
                  }
                }
                if(flag==0){
                  messageContainers.insert(0,messageContainer);
                }

              });
            });


          });

          Map<dynamic, dynamic> values2 = values1;
          values2.forEach((key3, values3) {
            String productId = key3;
            print("productId:" + productId);
            String lastMessageContent;
            String productPhotoUrl;

            values3.forEach((key4, values5) {
              String hashedKeyOfSingleMessage = key4;

              String senderUsername = values5["senderUsername"];
              String receiverUsername = values5["receiverUsername"];
              String messageContent = values5["messageContent"];
              productPhotoUrl = values5["productPhotoUrl"];

              lastMessageContent = messageContent;
            });
            print("lastMessageContent:" + lastMessageContent);
            MessageContainer messageContainer = new MessageContainer(
                productId, otherUsername, lastMessageContent,
                messagesReference.child(otherUsername).child(productId),productPhotoUrl);

            print(messageContainer.messagesReference.path);
            messageContainer.messagesReference.onChildAdded.listen((
                Event event) {
              print("2222222222222222");
              print("eventer.:"+event.snapshot.value.toString());


                setState(() {
                  //new message should seen in first of the list
                  print("bakalim");
                  messageContainers.remove(messageContainer);
                  messageContainer.lastMessage = event.snapshot.value["messageContent"];
                  messageContainers.insert(0,messageContainer);


                });






            });
            setState(() {
              messageContainers.add(messageContainer);
            });
          });
        });
      });


      //messagesReference.onChildChanged.listen(_onNewMessageSent);


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
              child: Text("Yükleniyor..."),
            ),
          ));
    } else {

      return Scaffold(
          appBar: new AppBar(
            titleSpacing: 0.0,
            title: Text("Mesajlarım"),
          ),
          body:  Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Color(0xfff98eda2),
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

              ],
            ),

      );
    }
  }


}