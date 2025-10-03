import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categories.dart';
import '../models/product.dart';
import '../services/token_storge.dart'; // ✅ Add this

class ApiService {
  static const String baseUrl = 'http://ackg0kcow88s8kks0kokko0s.168.231.110.172.sslip.io/api';

  // ✅ Dynamic headers with token
  static Future<Map<String, String>> _buildHeaders() async {
    final token = await TokenStorage.getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<List<Category>> getCategories() async {
    try {
      final headers = await _buildHeaders(); // ✅ Use here
      final response = await http.get(
        Uri.parse('$baseUrl/Categories'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  static Future<List<Product>> getProducts() async {
    try {
      final headers = await _buildHeaders(); // ✅ Use here
      final response = await http.get(
        Uri.parse('$baseUrl/Products'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  static Future<List<Product>> getProductsByCategory(String categoryName) async {
    try {
      final allProducts = await getProducts();
      return allProducts.where((product) => product.categoryName == categoryName).toList();
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }
}
