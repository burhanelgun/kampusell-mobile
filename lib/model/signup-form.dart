class SignUpForm {
  String username;
  String email;
  String password;
  String activationCode;
  SignUpForm(this.username, this.email,this.password);



  SignUpForm.fromJson(Map<String, dynamic> json) {
    this.username = json['username'].toString();
    this.email = json['email'].toString();
    this.password = json['password'].toString();
    this.activationCode = json['activationCode'].toString();

  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'password': password,
    'role' :["user","pm"],
    'activationCode':activationCode
  };
}
