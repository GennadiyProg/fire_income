
import 'package:fire_income/models/category.dart';

import 'Branch.dart';

class Statistic {
  Category? category;
  Branch? branch;
  DateTime? date;
  int? count;

  Statistic.empty();

  Statistic({this.category, this.branch, this.date, this.count});

  static Statistic fromJson(Map<String, dynamic> json) {
    Statistic s = Statistic();
    s.category = json['category'] != null ? Category.fromJson(json['category']) : null ;
    s.branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    s.count = json['count'];
    s.date = json['date'] != null ? DateTime.tryParse(json['date']) : null;

    return s;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'category': category?.toJson(),
        'seller': branch?.toJson(),
        'count': count,
        'date': date.toString(),
      };
}
