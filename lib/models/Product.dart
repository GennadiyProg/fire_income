
import 'Category.dart';

class Product{
  String? id;
  String? name;
  Category? category;
  String? measureUnit;

  Product.empty();

  Product({this.id,this.name, this.category, this.measureUnit});

  static Product fromJson(Map<String, dynamic> json) {
    Product p = Product();
    p.id = json['id'];
    p.name = json['name'];
    p.category = Category.fromJson(json['category']);
    p.measureUnit = json['measureUnit'];

    return p;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'category': category?.toJson(),
    'measureUnit': measureUnit,
  };

  @override
  int get hashCode {
    return "$id $name".hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is Product) {
      return other.id == id && other.name == name;
    }
    return false;
  }

  @override
  String toString() {
    return "$id.$name";
  }
}

enum MeasureUnit {
  L,
  KG,
  UNIT
}