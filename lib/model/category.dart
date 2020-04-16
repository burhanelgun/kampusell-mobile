class Category {
  String id;
  String name;

  Category(this.id, this.name);

  static List<Category> fetchAll() {
    return [
      Category('1', 'Kitap'),
      Category('2', 'Elektronik'),
      Category('3', 'Giyim'),
      Category('4', 'Emlak')
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
