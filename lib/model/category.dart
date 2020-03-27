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
    this.id=json['id'].toString();
    this.name = json['name'].toString();

  }

  Map<String, dynamic> toJson() =>
  {
    'id': id,
    'name': name,
  };


}