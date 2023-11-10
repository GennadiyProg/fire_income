class Product{
  String? name;
  String? category;
  String? measureUnit;


  Product.empty();

  Product({this.name, this.category, this.measureUnit});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      name: json['name'],
      category: json['category'],
      measureUnit: json['measureUnit'],
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'category': category,
    'measureUnit': measureUnit,
  };


}