class SignInForm {
  String username;
  String password;

  SignInForm(this.username, this.password);

  SignInForm.fromJson(Map<String, dynamic> json) {
    this.username = json['username'].toString();
    this.password = json['password'].toString();
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
