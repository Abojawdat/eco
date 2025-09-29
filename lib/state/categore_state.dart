import '../services/API SERVIC.dart';
import '../models/categories.dart';
class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState{
  final List<Category> categories ;

  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  /// Error message describing what went wrong
  final String message;

  CategoryError(this.message);
}