import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categories.dart';
import '../models/product.dart';

/// API Service class that handles all communication with the backend
/// This class provides methods to fetch categories and products from the API
class ApiService {
  /// Base URL of the API server
  static const String baseUrl = 'http://ackg0kcow88s8kks0kokko0s.168.231.110.172.sslip.io/api';

  /// HTTP headers for API requests
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Fetches all categories from the API
  /// Returns a list of Category objects
  /// Throws an exception if the request fails
  static Future<List<Category>> getCategories() async {
    try {
      // Make HTTP GET request to the categories endpoint
      final response = await http.get(
        Uri.parse('$baseUrl/Categories'),
        headers: headers,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response into a list of dynamic objects
        final List<dynamic> jsonList = json.decode(response.body);
        // Convert each JSON object to a Category object
        return jsonList.map((json) => Category.fromJson(json)).toList();
      } else {
        // Throw exception if the response status is not 200
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any network or parsing errors
      throw Exception('Error fetching categories: $e');
    }
  }

  /// Fetches all products from the API
  /// Returns a list of Product objects
  /// Throws an exception if the request fails
  static Future<List<Product>> getProducts() async {
    try {
      // Make HTTP GET request to the products endpoint
      final response = await http.get(
        Uri.parse('$baseUrl/Products'),
        headers: headers,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response into a list of dynamic objects
        final List<dynamic> jsonList = json.decode(response.body);
        // Convert each JSON object to a Product object
        return jsonList.map((json) => Product.fromJson(json)).toList();
      } else {
        // Throw exception if the response status is not 200
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any network or parsing errors
      throw Exception('Error fetching products: $e');
    }
  }

  /// Fetches products filtered by category name
  /// First gets all products, then filters them by category
  /// Returns a list of Product objects that belong to the specified category
  static Future<List<Product>> getProductsByCategory(String categoryName) async {
    try {
      // Get all products first
      final allProducts = await getProducts();
      // Filter products by the specified category name
      return allProducts.where((product) => product.categoryName == categoryName).toList();
    } catch (e) {
      // Catch any errors from the getProducts method
      throw Exception('Error fetching products by category: $e');
    }
  }
}
