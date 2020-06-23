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