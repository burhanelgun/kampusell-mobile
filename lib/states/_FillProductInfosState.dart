



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:http/http.dart' as http;

class FillProductInfosState extends State<FillProductInfosScreen>{
  Category productCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();

  FillProductInfosState();

  @override
  Widget build(BuildContext context) {


    return  new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            title: Text("ürün bilgilerini giriniz")
        ),
        body: Builder(
          builder: (context) => Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                        children: <Widget>[
                          // Add TextFormFields and RaisedButton here.
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ürün Adı'
                            ),
                            controller: productNameController,


                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ürün Açıklaması'
                            ),
                            controller: productDescriptionController,

                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: productPriceController,
                            keyboardType: TextInputType.multiline,
                            maxLength: 1450,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Ürün Fiyatı'
                            ),
                          ),
                          DropdownButtonFormField<Category>(
                            value:  productCategory != null ?productCategory : null,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            hint: Text("Kategori Seçiniz"),
                            style: TextStyle(color: Colors.deepPurple),
                            onChanged: (Category newValue) {
                              setState(() {
                                productCategory = newValue;
                              });
                            },
                            items: categories
                                .map<DropdownMenuItem<Category>>((Category category) {
                              return DropdownMenuItem<Category>(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                          ),
                          RaisedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.

                                Product product= new Product(null
                                    , productNameController.text
                                    , productDescriptionController.text
                                    , double.parse(productPriceController.text)
                                    , null
                                    , null
                                    , productCategory);
                                createProduct(product);

                                Scaffold.of(context)
                                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                                  print("satışa çıkarıldı");
                              }
                            },
                            child: Text('Satışa Çıkar'),
                          )
                        ]
                    )
                ),




              ],
            ) ,

          ),

        )

      )
    );
  }

  Future<http.Response> createProduct(Product product) {
    //      'http://10.0.2.2:8080/api/products/s',
    return http.post(
      'https://kampusell-api.herokuapp.com/api/products/s',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product),
    );
  }


  Future<bool> _onWillPop() async{
    Navigator.of(context).pop(true);
    print("merhabalaf");
    return false;
  }
}