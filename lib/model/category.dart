import 'package:kampusell/model/product.dart';

class Category{
  String id;
  String name;
  Category(this.id,this.name);

  static List<Category> fetchAll(){
    return [
      Category(
        '1',
        'Kitap'
      ),
      Category(
        '2',
        'Elektronik'
      ),
      Category(
        '3',
        'Eşya'
      ),
      Category(
        '4',
        'Giyim'
      ),
      Category(
        '5',
        'Emlak'
      ),
      Category(
          '6',
          'Kitap'
      ),
      Category(
          '7',
          'Elektronik'
      ),
      Category(
          '8',
          'Eşya'
      ),
      Category(
          '9',
          'Giyim'
      ),
      Category(
          '10',
          'Emlak'
      ),
    ];
  }

  Category.fromJson(Map<String, dynamic> json){
    print("denemeee1");
    this.id=json['id'].toString();
    print("denemeee2");
    this.name = json['name'].toString();
    print("denemeee3");

  }

}