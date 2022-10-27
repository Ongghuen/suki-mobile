class LoggedUser {
  final String username;
  final String password;
  final String msg;

  const LoggedUser({
    required this.username,
    required this.password,
    required this.msg,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      username: json["result"][0]["username"],
      password: json["result"][0]["password"],
      msg: json['msg'],
    );
  }
}
