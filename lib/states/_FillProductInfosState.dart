import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import '../main.dart';

class FillProductInfosState extends State<FillProductInfosScreen> {
  Category productCategory = null;
  final _formKey = GlobalKey<FormState>();
  final List<Category> categories = Category.fetchAll();
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  File _image;
  String _text = " ";
  String _labelText = " ";
  final picker = ImagePicker();
  String _fileUrl;

  List<String> photoPaths = new List();
  List<String> texts =new List();
  List<String> labels =new List();
  JwtModel jwtModel;

  FillProductInfosState(this.jwtModel);

  Future getImage() async {
    PickedFile pickedFile = (await picker.getImage(
        source: ImageSource.gallery));
    File file = File(pickedFile.path);


    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(file);


    //Label recognizer
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> imageLabels = await labeler.processImage(
        visionImage);
    for (ImageLabel label in imageLabels) {
      final double confidence = label.confidence;

      labels.add(label.text);


    }
    labeler.close();

    //Text recognizer
    final TextRecognizer textRecognizer = FirebaseVision.instance
        .textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = "";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
            text = text + word.text + ' ';
            if(texts.length<5){
              texts.add(word.text);
            }
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();

    print("-----------------------------------");

    if (mounted) {
      setState(() {
        _image = file;
      });
    }
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child(productNameController.text);
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      _fileUrl=fileURL;
      print(_fileUrl);
    });

  }

  Future<http.Response> createProduct(Product product) {
    //'http://10.0.2.2:8080/api/products/s',
    //'http://192.168.1.36:8080/api/products/s',
    //'https://kampusell-api.herokuapp.com/api/products/s'

    if (isLocal) {
      return http.post(
        'http://10.0.2.2:8080/api/products/s',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(product),
      );
    } else {
      return http.post(
        'https://kampusell-api.herokuapp.com/api/products/s',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(product),
      );
    }
  }

  Future uploadFile() {

      setState(() {
        photoPaths.add(_fileUrl);
        Product product = new Product(
            null,
            productNameController.text,
            productDescriptionController.text,
            double.parse(productPriceController.text),
            photoPaths,
            null,
            productCategory,
            texts,
            labels);
        createProduct(product);
      });

  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(titleSpacing: 0.0, title: Text("Ürün bilgileri")),
            body: Builder(
              builder: (context) => Container(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                          child: _image == null
                              ? Text('')
                              : Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: new DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(_image))))),
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
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
                                  labelText: 'Ürün Adı'),
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
                                  labelText: 'Ürün Açıklaması'),
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
                                  labelText: 'Ürün Fiyatı'),
                            ),
                            DropdownButtonFormField<Category>(
                              value: productCategory != null
                                  ? productCategory
                                  : null,
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
                              items: categories.map<DropdownMenuItem<Category>>(
                                  (Category category) {
                                return DropdownMenuItem<Category>(
                                  value: category,
                                  child: Text(category.name),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 20),
                            FloatingActionButton(
                              onPressed: getImage,
                              tooltip: 'Pick Image',
                              child: Icon(Icons.add_a_photo),
                            ),
                            SizedBox(height: 20),

                            Padding(
                              padding: const EdgeInsets.all(9),
                              child: Material(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.pink,
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState.validate()) {
                                        // If the form is valid, display a snackbar. In the real world,
                                        // you'd often call a server or save the information in a database.
                                        await uploadFile();
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Satışa Çıkarıldı.')));
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Satışa Çıkar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                          ])),
                    ],
                  ),
                ),
              ),
            )));
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).pop(true);
    return false;
  }
}
