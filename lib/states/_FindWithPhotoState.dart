
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
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
                    width: 250.0,
                    height: 250.0,
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
            Center(
                child: _text == null
                    ? Text('Etiketler')
                    : Text(_text)),

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


}
