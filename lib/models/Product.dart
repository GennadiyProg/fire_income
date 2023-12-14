
import 'Category.dart';

class Product{
  String? name;
  Category? category;
  String? measureUnit;

  Product.empty();

  Product({this.name, this.category, this.measureUnit});

  static Product fromJson(Map<String, dynamic> json) {
    Product p = Product();
    p.name = json['name'];
    p.category = Category.fromJson(json['category']);
    p.measureUnit = json['measureUnit'];

    return p;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'category': category?.toJson(),
    'measureUnit': measureUnit,
  };
}

enum MeasureUnit {
  L,
  KG,
  UNIT
}