class Category {
  String? id;
  String? name;

  Category.empty();

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };

  @override
  int get hashCode {
    return "$id $name".hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (other is Category) {
      return other.id == id && other.name == name;
    }
    return false;
  }

  @override
  String toString() {
    return "$id.$name";
  }
}
