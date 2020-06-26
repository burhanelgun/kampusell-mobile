import 'package:kampusell/model/student.dart';

import 'category.dart';

class Product {
  String id;
  String name;
  String description;
  double price;
  List<String> imagePaths;
  List<String> texts;
  String label1;
  String label2;
  Student student;
  Category category;

  Product(this.id, this.name, this.description, this.price, this.imagePaths,
      this.student, this.category,this.texts,this.label1,this.label2);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'student': student,
      'imagePaths': imagePaths,
      'texts': texts,
      'label1': label1,
      'label2': label2,

    };
  }
}
