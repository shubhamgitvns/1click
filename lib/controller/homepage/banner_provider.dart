import 'package:flutter/material.dart';

import '../../data/model/home/banner_model.dart';
import '../../service/home/banner_api.dart';

class BannerProvider with ChangeNotifier {
  final BannerApiService _apiService = BannerApiService();
  List<BannerModel> _banners = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<BannerModel> get banners => _banners;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String vendorId = "88e06cdb-bdde-11ef-ad07-00163c34c678";
  Future<void> loadBanners() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      List<BannerModel> fetchedBanners = await _apiService.fetchBanners();
      _banners = fetchedBanners;
    } catch (e) {
      _errorMessage = e.toString();
      _banners = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Filter banners based on vendorId.
  List<BannerModel> getBannersByVendor() {
    return _banners.where((banner) => banner.vendorId == vendorId).toList();
  }
}
