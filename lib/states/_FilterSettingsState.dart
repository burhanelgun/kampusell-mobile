import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/model/product-filter.dart';

class FilterSettingsState extends State<FilterSettingsScreen> {
  String jwt;
  FilterSettingsState(this.jwt);
  Category selectedCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
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
          title: Text("Filtre"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              DropdownButtonFormField<Category>(
                value: selectedCategory != null
                    ? selectedCategory
                    : null,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                hint: Text("Kategori Seçiniz"),
                style: TextStyle(color: Colors.deepPurple),
                onChanged: (Category newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
                items: categories.map<DropdownMenuItem<Category>>(
                        (Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: minPriceController,
                keyboardType: TextInputType.multiline,
                maxLength: 1450,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Minimum Fiyat'),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: maxPriceController,
                keyboardType: TextInputType.multiline,
                maxLength: 1450,
                maxLines: null,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Maximum Fiyat'),
              ),
              RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    filterProducts();
                  }
                },
                child: Text('Filtrele'),
              )
            ],
          ),
        )
    );
  }

  void filterProducts() {

    print("merhabalarrr");
    ProductFilter productFilter = new ProductFilter(selectedCategory,minPriceController.text,maxPriceController.text);
    Navigator.of(context).pop(productFilter);


  }
}
