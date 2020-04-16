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

  //for try(remove below later)
  Product.foo(this.id, this.name, this.description, this.price, this.category,
      this.imagePaths) {
    this.student = new Student(1, "burhanelgun", "burhan", "elgun",
        "belgun@gtu.edu.tr", new List<Product>());
  }

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
