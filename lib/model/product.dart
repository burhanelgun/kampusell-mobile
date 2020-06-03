import 'package:kampusell/model/student.dart';

import 'category.dart';

class Product {
  String id;
  String name;
  String description;
  double price;
  List<String> imagePaths;
  Student student;
  Category category;

  Product(this.id, this.name, this.description, this.price, this.imagePaths,
      this.student, this.category);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'student': student,
      'imagePaths': imagePaths
    };
  }
}
