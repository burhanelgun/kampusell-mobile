
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/photo-value.dart';
import 'package:kampusell/model/product-filter.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/find-with-photo/find-with-photo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FindWithPhotoState extends State<FindWithPhotoScreen> {
  File _image;
  String _text = " ";
  String _labelText = " ";
  final picker = ImagePicker();
  List<String> texts =new List();
  List<String> labels =new List();

  FindWithPhotoState();

  @override
  void initState() {
    super.initState();

    getImage();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            titleSpacing: 0.0,
            title: Text("Fotoğraf ile Ürün Ara"),
        ),
        body: Column(
          children: <Widget>[
            Center(
                child: _image == null
                    ? Text('')
                    : Container(
                    width: 350.0,
                    height: 350.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_image))))),
            Center(
                child: _labelText == null
                    ? Text('Kelimeler')
                    : Text(_labelText)),
            Divider(color: Colors.red),

            Padding(
              padding: const EdgeInsets.all(9),
              child: Material(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.pink,
                  elevation: 0.0,
                  child: MaterialButton(
                    onPressed: () {
                       findWithPhotoBtnClick();
                    },
                    minWidth: MediaQuery.of(context).size.width,
                    child: Text(
                      'Benzer Ürünleri Getir',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  )),
            ),

          ],
        )

    );
  }

  Future<void> getImage() async {

    PickedFile pickedFile = (await picker.getImage(source: ImageSource.gallery));
    File file = File(pickedFile.path);



    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(file);


    //Label recognizer
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    final List<ImageLabel> imageLabels = await labeler.processImage(visionImage);
    String labelText = "";
    for (ImageLabel label in imageLabels) {
      final double confidence = label.confidence;
      if(labels.length<5){
        labels.add(label.text);
      }
      labelText = labelText + label.text + ":  " + confidence.toStringAsFixed(2)+ "\n";
    }
    labeler.close();

    //Text recognizer
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = "";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          if(texts.length<5){
            texts.add(word.text);
          }
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();



  if(mounted){
    setState(() {
      _image =file;
      _labelText = labelText;
      _text = text;
    });

  }

  }

  void findWithPhotoBtnClick() {
    PhotoValue photoValue = new PhotoValue(texts,labels);
    Navigator.of(context).pop(photoValue);
  }


}
