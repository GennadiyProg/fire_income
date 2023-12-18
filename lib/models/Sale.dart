
import 'package:fire_income/models/Product.dart';

import 'User.dart';

class Sale {
  String? id;
  Product? product;
  User? seller;
  int? amount;
  String? time;

  Sale.empty();

  Sale({this.id, this.product, this.seller, this.amount});

  static Sale fromJson(Map<String, dynamic> json) {
    Sale s = Sale();
    s.product = Product.fromJson(json['product']);
    s.seller = User.fromJson(json['seller']);
    s.amount = json['amount'];
    s.time = json['time'];

    return s;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'product': product?.toJson(),
        'seller': seller?.toJson(),
        'amount': amount,
        'time': time,
      };
}