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

        if(username!=message.senderUsername){
           /* return Container(
                child: Text(message.senderUsername+" "+ message.receiverUsername
                    +" "+message.messageContent,
                    textAlign: TextAlign.end, // has impact

                ),

            );*/
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                  children: [
                      Icon(Icons.account_circle),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                  message.senderUsername,
                                  style: Theme.of(context).textTheme.caption,
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * .6),
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color:  Color(0xfffe6e9ed),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                      ),
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          message.messageContent,
                                         /* style: Theme.of(context).textTheme.body1.apply(
                                              color: Colors.black,

                                          ),*/
                                          style: new TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                          ),
                                      ),
                                        Text(
                                           message.formattedDate,
                                            style: new TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                            ),
                                      ),
                                    ],
                                  ),
                              ),
                          ],
                      ),
                      SizedBox(width: 5),

                  ],
              ),
            );
        }
        else{
           /* return Container(
                child: Text(message.senderUsername+" "+ message.receiverUsername
                    +" "+message.messageContent,
                ),

            );*/

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * .6),
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xfffDCF8C6),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                      ),
                                  ),
                                  child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                          Text(
                                              message.messageContent,
                                              /* style: Theme.of(context).textTheme.body1.apply(
                                              color: Colors.black,

                                          ),*/
                                              style: new TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                              ),
                                          ),
                                          Text(
                                              message.formattedDate,
                                              style: new TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                              ),
                                          ),
                                      ],
                                  ),
                              ),
                          ],
                      ),


                  ],
              ),
            );

        }


    }

}