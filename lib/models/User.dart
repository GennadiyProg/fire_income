class User {
  String? id;
  String? surname;
  String? firstName;
  String? lastName;
  String? password;
  String? passport;
  bool? active;
  String? role;

  User.empty();

  Map<String, dynamic> toJson() => {
    'id': id,
    'surname': surname,
    'firstName': firstName,
    'lastName': lastName,
    'password': password,
    'passport': passport,
    'active': active,
    'role': role,
  };
}
