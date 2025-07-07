import 'package:flutter/material.dart';

import '../data/model/sub_categery_model.dart';
import '../data/model/sub_categery_responce.dart';
import '../service/sub_categery_service.dart';

class SubCategoryProvider with ChangeNotifier {
  final SubCategoryApiService _apiService = SubCategoryApiService();
  List<SubCategory> _allSubCategories = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<SubCategory> get allSubCategories => _allSubCategories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // This method loads all subcategories from the API just once.
  Future<void> loadAllSubCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      SubCategoryResponse response = await _apiService.fetchSubCategories();
      _allSubCategories = response.data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // This method filters the stored subcategories based on a given category id.
  List<SubCategory> getSubCategoriesByCategory(String categoryId) {
    return _allSubCategories
        .where((subCat) => subCat.category == categoryId)
        .toList();
  }
}
