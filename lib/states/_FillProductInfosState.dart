



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';

class FillProductInfosState extends State<FillProductInfosScreen>{
  final CategoryItem _categoryItem;
  Category dropdownValue = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();

  FillProductInfosState(this._categoryItem);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(_categoryItem.category.name+" kategorisi için ürün bilgilerini giriniz")
      ),
      body:Container(
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ürün Adı'
                        ),

                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ürün Açıklaması'
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLength: 1450,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ürün Fiyatı'
                        ),
                      ),
                      DropdownButtonFormField<Category>(
                        value:  dropdownValue != null ?dropdownValue : null,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (Category newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: categories
                            .map<DropdownMenuItem<Category>>((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                      )
                    ]
                )
            ),




          ],
        ) ,

      ),



    );
  }

}