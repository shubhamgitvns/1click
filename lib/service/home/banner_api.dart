import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/model/home/banner_model.dart';
import '../../utility/app_constant.dart';
import '../../utility/local_storage.dart';

class BannerApiService {
  Future<List<BannerModel>> fetchBanners() async {
    String? token = await StorageHelper.getToken();
    final url = Uri.parse("${AppConstant.baseUrl}${AppConstant.bannerUrl}");

    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "$token", // Replace with your token if needed.
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print("Banner");
      print(data);
      List<dynamic> bannerJson = data['data']['banners'];
      return bannerJson.map((json) => BannerModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load banners");
    }
  }
}
