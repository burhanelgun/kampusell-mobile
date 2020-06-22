import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/send-message-to-seller/send-message-to-seller.dart';

class SendMessageToSellerState extends State<SendMessageToSellerScreen> {
  SendMessageToSellerState();

  final _formKey = GlobalKey<FormState>();
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          titleSpacing: 0.0,
          title: Text("Ürünleri Filtrele"),
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
                  child: Text('Left', textAlign: TextAlign.center),
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
        )
        );
  }
}
