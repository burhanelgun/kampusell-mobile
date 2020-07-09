import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/message-container.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/providers/jwt_model.dart';

import '../../main.dart';

class ProductScreen extends StatelessWidget {
  Product product;
  JwtModel _jwtModel;

  ProductScreen(this.product, this._jwtModel);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0.0, title: Text(product.name)),
      body: SafeArea(
          child: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Image.network(
                    product.imagePaths[0],
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      product.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      product.price.toString() + "TL",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text("Ürün Açıklaması",
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.description,
                                style: TextStyle(color: Colors.black)),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.account_circle),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.student.username),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    getPaddind(context)

                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void sendMessageToSellerBtnClick(BuildContext context) {
    MessageContainer messageContainer = new MessageContainer(product.name, product.student.username, "", null,product.imagePaths[0]);
    Navigator.pushNamed(context, SendMessageToSellerRoute,arguments: {
      "jwtModel": _jwtModel,
      "messageContainer": messageContainer
    }).then((value) async {

    });


  }

  Padding getPaddind(BuildContext context) {
    if(product.student.username!=_jwtModel.getUsername()){
      return Padding(
        padding: const EdgeInsets.all(9),
        child: Material(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.pink,
            elevation: 0.0,
            child: MaterialButton(
              onPressed: () {
                sendMessageToSellerBtnClick(context);
              },
              minWidth: MediaQuery.of(context).size.width,
              child: Text(
                "Satıcıya Mesaj Gönder",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            )),
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.all(9),
        child: Material(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.pink,
            elevation: 0.0,
            child: MaterialButton(
              onPressed: () {

              },
              minWidth: MediaQuery.of(context).size.width,
              child: Text(
                "Düzenle",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            )),
      );
    }

  }
}
