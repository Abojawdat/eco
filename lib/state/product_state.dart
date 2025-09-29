import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../services/API SERVIC.dart';

 class Productstate {}

class ProductInitial extends Productstate {}

class ProductLoading extends Productstate {}

class ProductLoaded extends Productstate{
  final List<Product> products ;

  ProductLoaded(this.products);
}

class ProductError extends Productstate {
  /// Error message describing what went wrong
  final String message;

  ProductError(this.message);
}