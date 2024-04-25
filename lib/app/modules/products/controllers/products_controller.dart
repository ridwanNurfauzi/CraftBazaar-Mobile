import 'dart:convert';

import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  var isLoading = true.obs;

  var products = [].obs;

  var dropdownValue = 'latest'.obs;

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

  Future<void> fetchLatestProducts() async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/products/latest";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        products.value = jsonResponse.toList();
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

  Future<void> fetchPopularProducts() async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/products/popular";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        products.value = jsonResponse.toList();
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

  Future<void> fetchEarliestProducts() async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/products/earliest";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        products.value = jsonResponse.toList();
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

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/products";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
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
