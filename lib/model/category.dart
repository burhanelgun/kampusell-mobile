class Category {
  String id;
  String name;
  String iconName;

  Category(this.id, this.name, this.iconName);

  static List<Category> fetchAll() {
    return [
      Category('1', 'Kitaplar', "kitap.png"),
      Category('2', 'Materyaller', "materyal.png"),
      Category('3', 'Notlar', "not.png"),
      Category('4', 'Elektronik', "elektronik.png"),
      Category('5', 'Emlak', "emlak.png"),
    ];
  }

  Category.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'].toString();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
