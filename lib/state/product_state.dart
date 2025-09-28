import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../services/API SERVIC.dart';

 class Productstate {}

class ProductInitial extends Productstate {}

class Productloading extends Productstate {}

class Productloaded extends Productstate{
  final List<Product> products ;

  Productloaded(this.products);
}

class ProductError extends Productstate {
  /// Error message describing what went wrong
  final String message;

  ProductError(this.message);
}