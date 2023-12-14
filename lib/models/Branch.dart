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

  static Branch fromJson(Map<String, dynamic> json) {
    Branch b = Branch();
    b.id = json['id'];
    b.city = json['city'];
    b.street = json['street'];
    b.house = json['house'];
    b.kpp = json['kpp'];
    List<dynamic> sellers =
        json['sellers'].map((e) => User.fromJson(e)).toList();
    b.sellers = [...sellers];
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
