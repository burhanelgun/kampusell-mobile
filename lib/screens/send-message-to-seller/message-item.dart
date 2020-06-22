import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message.dart';
import 'package:kampusell/model/product.dart';

import '../../main.dart';

class MessageItem extends StatelessWidget {
    Message message;

    MessageItem(this.message);

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Text(message.senderUsername+" "+ message.receiverUsername
            +" "+message.messageContent),
        );
    }

}