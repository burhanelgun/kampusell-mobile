import 'package:kampusell/model/student.dart';

import 'category.dart';

class Product {
  String id;
  String name;
  String description;
  double price;
  List<String> imagePaths;
  List<String> texts;
  List<String> labels;
  Student student;
  Category category;

  Product(this.id, this.name, this.description, this.price, this.imagePaths,
      this.student, this.category,this.texts,this.labels);

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
      'labels': labels,

    };
  }
}
