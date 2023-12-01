import 'package:fire_income/models/User.dart';

class Branch {
  String? id;
  String? city;
  String? street;
  String? house;
  String? kpp;
  List<User>? sellers;

  Branch.empty() : sellers = List.empty();

  Branch({this.id, this.city, this.street, this.house, this.kpp});

  // Branch.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       city = json['city'],
  //       street = json['street'],
  //       house = json['house'],
  //       kpp = json['kpp'];

  static Branch fromJson(Map<String, dynamic> json) {
    Branch b = Branch();
    b.id = json['id'];
    b.city = json['city'];
    b.street = json['street'];
    b.house = json['house'];
    b.kpp = json['kpp'];
    List<dynamic> sellers = json['sellers'].map((e) => User.fromJson(e)).toList();
    b.sellers = sellers.map((e) => User.fromJson(e)).toList();
    return b;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'city': city,
        'street': street,
        'house': house,
        'kpp': kpp,
        'sellers': sellers?.map((e) => e.toJson()).toList()
      };
}
