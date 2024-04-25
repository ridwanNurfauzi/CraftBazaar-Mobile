import 'dart:convert';

import 'package:craftbazaar/app/data/models/product.dart';
import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var product = Product().obs;

  var isLoading = true.obs;

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

  Future<void> fetchProductBySlug(String slug) async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/products/slug/$slug";

      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body)['data'];
        product.value = Product.fromJson(jsonResponse);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Gagal memuat data produk terbaru.');
      }
    } catch (e) {
      isLoading.value = false;
      print('Gagal memuat data produk terbaru. {$e}');
    }
  }
}
