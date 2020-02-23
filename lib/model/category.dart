import 'package:kampusell/model/product.dart';

class Category{
  String id;
  String name;
  String imagePath;
  List<Product> products;
  Category(this.id,this.name,this.imagePath,this.products);

  static List<Category> fetchAll(){
    return [
      Category(
        '1',
        'Kitap',
        'assets/images/kitap.png',
        new List<Product>()
      ),
      Category(
        '2',
        'Elektronik',
        'assets/images/elektronik.png',
        new List<Product>()
      ),
      Category(
        '3',
        'Eşya',
        'assets/images/esya.png',
        new List<Product>()
      ),
      Category(
        '4',
        'Giyim',
        'assets/images/giyim.png',
        new List<Product>()
      ),
      Category(
        '5',
        'Emlak',
        'assets/images/emlak.png',
        new List<Product>()
      ),
      Category(
          '6',
          'Kitap',
          'assets/images/kitap.png',
          new List<Product>()
      ),
      Category(
          '7',
          'Elektronik',
          'assets/images/elektronik.png',
          new List<Product>()
      ),
      Category(
          '8',
          'Eşya',
          'assets/images/esya.png',
          new List<Product>()
      ),
      Category(
          '9',
          'Giyim',
          'assets/images/giyim.png',
          new List<Product>()
      ),
      Category(
          '10',
          'Emlak',
          'assets/images/emlak.png',
          new List<Product>()
      ),
    ];
  }

}