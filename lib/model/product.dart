import 'package:kampusell/model/student.dart';

import 'category.dart';

class Product{
  String id;
  String name;
  String description;
  double price;
  List<String> photoPaths;
  Student owner;
  Category category;
  Product(this.id,this.name,this.description,this.price,this.photoPaths,this.owner,this.category);
  //for try(remove below later)
  Product.foo(this.id,this.name,this.description,this.price){
    print("burhan1");
    List<String> photoPaths = new List();
    photoPaths.add("assets/images/kitap.png");
    this.photoPaths=photoPaths;
    this.owner=new Student(
        1,
        "burhanelgun",
        "burhan",
        "elgun",
        "belgun@gtu.edu.tr",
        "123456789",
        new List<Product>(),
        new List<Product>());
    this.category=new Category(
        '1', 'Kitap', 'assets/images/kitap.png', new List<Product>());
  }

  Product.convertToProduct(Product p){
    List<String> photoPaths = new List();
    photoPaths.add("assets/images/kitap.png");
    this.id = p.id;
    this.name = p.name;
    this.description =p.description;
    this.price = p.price;
    this.photoPaths=p.photoPaths;
    this.owner=p.owner;
    this.category=p.category;

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
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '2',
          'Mat 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '3',
          'Kimya 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '4',
          'Biyoloji 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '5',
          'İngilizce 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '6',
          'Yapay Zeka 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '7',
          'Tarih 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '8',
          'Rusça 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '9',
          'Geometri 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      ),
      Product(
          '10',
          'Coğrafya 1',
          'Az kullanılmıştır.',
          25.6,
          photoPaths,
          new Student(
              1,
              "burhanelgun",
              "burhan",
              "elgun",
              "belgun@gtu.edu.tr",
              "123456789",
              new List<Product>(),
              new List<Product>()),
          new Category(
              '1', 'Kitap', 'assets/images/kitap.png', new List<Product>())
      )
    ];
  }


}