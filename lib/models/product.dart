import 'dart:ffi';

class Product {
  final int id;

  final String name;

  final double price;

  final String imageUrl;
  final String categoryName;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.categoryName,
  });

  /// This is used when receiving data from the API
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      categoryName: json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'categoryName': categoryName,
    };
  }

  /// Returns the price formatted as a string with dollar sign
  String get formattedPrice {
    return '\$${price.toStringAsFixed(2)}';
  }

  /// Getter that returns the complete image URL
  /// Combines the base API URL with the relative image path
  String get fullImageUrl {
    // Base URL of the API server
    const baseUrl = 'http://ackg0kcow88s8kks0kokko0s.168.231.110.172.sslip.io';
    return baseUrl + imageUrl;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, imageUrl: $imageUrl, categoryName: $categoryName}';
  }

  /// Two products are equal if all their properties match
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.categoryName == categoryName;
  }

  /// Hash code for the Product object
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        categoryName.hashCode;
  }
}
