import '../services/API SERVIC.dart';
import '../models/categories.dart';
class CategoryState {}

class CategoryInitial extends CategoryState {}

class Categoryloading extends CategoryState {}

class Categoryloaded extends CategoryState{
  final List<Category> categories ;

  Categoryloaded(this.categories);
}

class CategoryError extends CategoryState {
  /// Error message describing what went wrong
  final String message;

  CategoryError(this.message);
}