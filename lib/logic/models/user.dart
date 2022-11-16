class User {
  final String username;
  final String password;
  final String msg;

  const User({
    required this.username,
    required this.password,
    required this.msg,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json["result"][0]["username"],
      password: json["result"][0]["password"],
      msg: json['msg'],
    );
  }
}

