import 'package:fire_income/models/User.dart';

class Organization{
  String? id;
  String? name;
  User? director;
  String? inn;

  Organization.empty();


  Organization({this.id, this.name, this.inn});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'director': director?.toJson() ?? '',
    'inn': inn,
  };

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    id: json['id'],
    name: json['name'],
    inn: json['inn'],
  );
}