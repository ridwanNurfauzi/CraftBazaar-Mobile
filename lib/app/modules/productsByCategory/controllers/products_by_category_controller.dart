import 'dart:convert';

import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductsByCategoryController extends GetxController {
  var isLoading = true.obs;

  var products = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchProductsByCategory(category) async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/categories/${category}";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse =
            json.decode(response.body)['data']['product_categories'];
        products.value = jsonResponse.toList();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Gagal memuat data produk.');
      }
    } catch (e) {
      isLoading.value = false;
      print('Gagal memuat data produk. {$e}');
    }
  }
}
