import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message-container.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/providers/jwt_model.dart';

import '../../main.dart';

class MessageContainerItem extends StatelessWidget {
  MessageContainer messageContainer;
  JwtModel _jwtModel;
  MessageContainerItem(this.messageContainer,this._jwtModel);

  @override
  Widget build(BuildContext context) {
     /*return Container(
       decoration: BoxDecoration(color: Colors.black54),
       child: ListTile(
           onTap: () => _onMessageContainerTap(context),
           contentPadding:
           EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
           leading: Container(
             padding: EdgeInsets.only(right: 15.0),
             decoration: new BoxDecoration(
                 border: new Border(
                     right:
                     new BorderSide(width: 1.0, color: Colors.white30))),
             child: Container(
                 width: 80.0,
                 height: 80.0,
                 decoration: new BoxDecoration(
                     shape: BoxShape.rectangle,
                     image: messageContainer.product.imagePaths == null
                         ? null
                         : new DecorationImage(
                         fit: BoxFit.cover,
                         image: NetworkImage(messageContainer.product.imagePaths[0])))),
           ),
           title: Text(
             messageContainer.product.name,
             style:
             TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
           ),
           // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

           subtitle: Row(
             children: <Widget>[
               Flexible(
                 child: Text(
                   _jwtModel.getUsername(),
                   style: TextStyle(
                       color: Colors.white, fontWeight: FontWeight.normal),
                 ),
               ),
               Flexible(
                 child: Text(
                  messageContainer.lastMessage,
                   style: TextStyle(
                       color: Colors.white, fontWeight: FontWeight.normal),
                 ),
               ),
             ],
           ),
           trailing: Icon(Icons.keyboard_arrow_right,
               color: Colors.white, size: 30.0)),
     );*/
    return Container(
      decoration: BoxDecoration(color: Colors.black54),
      child: ListTile(
          onTap: () => _onMessageContainerTap(context),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 15.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right:
                    new BorderSide(width: 1.0, color: Colors.white30))),
            child: Container(
                width: 80.0,
                height: 80.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image:  messageContainer.productPhotoUrl == null
                        ? null
                        : new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(messageContainer.productPhotoUrl))
                        )),
          ),
          title: Text(
            messageContainer.productId,
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      messageContainer.otherUsername,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      messageContainer.lastMessage,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0)),
    );
   /* return Container(
      child: Column(
        children: <Widget>[
          Text("messageContainer.lastMessage:"+messageContainer.lastMessage),
          Text("messageContainer.otherUsername:"+messageContainer.otherUsername),
          Text("messageContainer.productId:"+messageContainer.productId),
        ],
    ));
*/
  }

  _onMessageContainerTap(BuildContext context) {
    Navigator.pushNamed(context, SendMessageToSellerRoute,arguments: {
      "jwtModel": _jwtModel,
      "messageContainer": messageContainer
    }).then((value) async {

    });
  }
}
