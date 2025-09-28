class Category {
  final int id;

  final String name;

  Category({required this.id, required this.name});

  /// Factory constructor to create Category from JSON data
  /// This is used when receiving data from the API
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  /// String representation of the Category object
  @override
  String toString() {
    return 'Category{id: $id, name: $name}';
  }

  /// Two categories are equal if they have the same id and name
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id && other.name == name;
  }

  /// Hash code for the Category object
  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
