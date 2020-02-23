import 'package:kampusell/model/product.dart';

class Student{
  int id;
  String username;
  String name;
  String surname;
  String email;
  String password;
  List<Product> products;
  Student(this.id,this.username,this.name,this.surname,this.email,this.password,this.products);

}