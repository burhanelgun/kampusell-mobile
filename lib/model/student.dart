import 'package:kampusell/model/product.dart';

class Student {
  String id;
  String username;
  String name;
  String surname;
  String email;
  List<Product> products;

  Student(this.id, this.username, this.name, this.surname, this.email,
      this.products);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'name': name,
        'surname': surname,
        'email': email,
        'products': products
      };

  Student.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.username = json['username'].toString();
  }
}
