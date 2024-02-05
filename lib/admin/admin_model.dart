class Admin {
  String? adminID;
  String email;
  String password;

  Admin({
    this.adminID,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'adminID': adminID,
      'email': email,
      'password': password,
    };
  }

  Admin.fromMap(Map<String, dynamic> map)
      : adminID = map['adminID'],
        email = map['email'],
        password = map['password'];
}
