import 'package:kampusell/model/category.dart';

class ProductFilter {

  Category category;
  String minPrice;
  String maxPrice;

  ProductFilter(this.category, this.minPrice,this.maxPrice);


  Map<String, dynamic> toJson() => {
    'category': category,
    'minPrice': minPrice,
    'maxPrice': maxPrice
  };
}
