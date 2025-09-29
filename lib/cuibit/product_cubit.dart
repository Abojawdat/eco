import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/API SERVIC.dart';
import '../state/product_state.dart';

class ProductCubit extends Cubit<Productstate>{
  ProductCubit(): super(ProductInitial());

  Future<void> loadProducts() async {
    emit(ProductLoading());
    try{      // Fetch all products from the API

      final products = await ApiService.getProducts();
      // Emit success state with the loaded products

      emit(ProductLoaded(products));
    } catch (e){
      emit(ProductError(e.toString()));
    }
  }
  /// /// Method to load products filtered by category
  Future<void> loadProductsByCategory(String categoryName) async {
    // Emit loading state to show loading indicator
    emit(ProductLoading());
    try {
      // Fetch products filtered by category from the API
      final products = await ApiService.getProductsByCategory(categoryName);
      // Emit success state with the filtered products
      emit(ProductLoaded(products));
    } catch (e) {
      // Emit error state if something goes wrong
      emit(ProductError(e.toString()));
    }
  }
}
