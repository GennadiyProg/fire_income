class User {
  String? id;
  String? username;
  String? surname;
  String? firstName;
  String? lastName;
  String? password;
  String? passport;
  bool? active;
  String? role;

  User.empty();

  User({this.id, this.username, this.surname, this.firstName, this.lastName, this.password,
      this.passport, this.active, this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    surname: json['surname'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    password: json['password'],
    passport: json['passport'],
    active: json['active'],
    role: json['role'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'surname': surname,
    'firstName': firstName,
    'lastName': lastName,
    'password': password,
    'passport': passport,
    'active': active,
    'role': role,
  };
}
