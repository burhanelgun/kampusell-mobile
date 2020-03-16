import 'package:kampusell/model/product.dart';


class Student{
  int id;
  String username;
  String name;
  String surname;
  String email;
  List<Product> products;

  Student(this.id,this.username,this.name,this.surname,this.email,this.products);

}