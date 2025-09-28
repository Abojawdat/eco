import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/API SERVIC.dart';
import '../state/categore_state.dart';
/// Cubit class for managing category state
/// Handles loading categories from the API and managing the state
class CategoryCubit extends Cubit<CategoryState> {
  /// Constructor that initializes the cubit with the initial state
  CategoryCubit() : super(CategoryInitial());

  /// Method to load categories from the API
  /// Emits loading state, then success or error state based on the result
  Future<void> loadCategories() async {
    // Emit loading state to show loading indicator
    emit(Categoryloading());
    try {
      // Fetch categories from the API
      final categories = await ApiService.getCategories();
      // Emit success state with the loaded categories
      emit(Categoryloaded(categories));
    } catch (e) {
      // Emit error state if something goes wrong
      emit(CategoryError(e.toString()));
    }
  }
}
