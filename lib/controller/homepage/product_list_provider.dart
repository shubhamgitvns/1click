import 'package:flutter/material.dart';

import '../../data/model/product_list_model.dart';
import '../../service/home/product_list_api.dart';

class ProductListController with ChangeNotifier {
  List<ProductList> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductList> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProducts() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _products = await ProductListApiService.fetchProducts();
    } catch (e) {
      _errorMessage = 'Failed to load products: ${e.toString()}';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }
}
