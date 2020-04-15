import 'dart:convert';
import 'dart:io';

import 'package:kampusell/model/student.dart';

import 'category.dart';

class Product{
  String id;
  String name;
  String description;
  double price;
  List<String> imagePaths;
  Student student;
  Category category;
  Product(this.id,this.name,this.description,this.price,this.imagePaths,this.student,this.category);
  //for try(remove below later)
  Product.foo(this.id,this.name,this.description,this.price,this.category,this.imagePaths){
    this.student=new Student(
        1,
        "burhanelgun",
        "burhan",
        "elgun",
        "belgun@gtu.edu.tr",
        new List<Product>());


  }

  Product.convertToProduct(Product p){
    List<String> photoPaths = new List();
    photoPaths.add("assets/images/kitap.png");
    this.id = p.id;
    this.name = p.name;
    this.description =p.description;
    this.price = p.price;
    this.imagePaths=p.imagePaths;
    this.student=p.student;
    this.category=p.category;

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



  static fetchByID(String productID){
    List<Product> products = Product.fetchAll();

    for(int i =0;i<products.length;i++){
      if(productID==products[i].id){
        return products[i];
      }
    }
    return null;
  }

  static List<Product> fetchAll() {
    List<String> photoPaths = new List();
    photoPaths.add("assets/images/kitap.png");
    return [
      Product(
          '1',
          'Fizik 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '2',
          'Mat 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap',)
      ),
      Product(
          '3',
          'Kimya 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '4',
          'Biyoloji 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '5',
          'İngilizce 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '6',
          'Yapay Zeka 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '7',
          'Tarih 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '8',
          'Rusça 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '9',
          'Geometri 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      ),
      Product(
          '10',
          'Coğrafya 1',
          'Az kullanılmıştır.',
          25.6,
          null,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              new List<Product>()),
          new Category(
              '1', 'Kitap')
      )
    ];
  }


}