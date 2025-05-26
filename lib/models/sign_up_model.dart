class SignUpModel {
  String? name;
  String? phone;
  String? email;
  String? password;

  SignUpModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> userData = {};
    userData['f_name'] = this.name;
    userData['password'] = this.password;
    userData['email'] = this.email;
    userData['phone'] = this.phone;
    return userData;
  }
}
