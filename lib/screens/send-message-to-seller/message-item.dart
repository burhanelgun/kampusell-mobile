import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message.dart';
import 'package:kampusell/model/product.dart';

import '../../main.dart';

class MessageItem extends StatelessWidget {
    Message message;
    String username;

    MessageItem(this.message, this.username);

    @override
    Widget build(BuildContext context) {
        print("track2(message.senderUsername):"+message.senderUsername);
        print("track3(username):"+username);
        print("track4(message.messageContent):"+message.messageContent);

        if(username==message.senderUsername){
            return Container(
                child: Text(message.senderUsername+" "+ message.receiverUsername
                    +" "+message.messageContent,
                    textAlign: TextAlign.end, // has impact

                ),

            );
        }
        else{
            return Container(
                child: Text(message.senderUsername+" "+ message.receiverUsername
                    +" "+message.messageContent,
                ),

            );
        }


    }

}