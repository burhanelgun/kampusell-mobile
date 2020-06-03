class University {
  String id;
  String name;
  String email;

  University(this.id, this.name, this.email);

  University.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.name = json['name'].toString();
    this.email = json['email'].toString();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
      };
}
