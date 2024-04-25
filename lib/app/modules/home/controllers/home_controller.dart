// ignore_for_file: unnecessary_overrides, unused_import

import 'dart:convert';

import 'package:get/get.dart';

import 'package:craftbazaar/app/providers/api.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var subscriptionProducts = [].obs;
  var latestProducts = [].obs;
  var popularProducts = [].obs;
  var categories = [].obs;

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

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.get('token').toString();
  }

  Future<void> fetchSubscriptionProducts() async {
    try {
      var token = await getToken();
      if (token == null) throw Exception('Token tidak ditemukan.');

      var apiUrl = "${Api.baseUrl}/user/sellers/subscriptions/products";

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        subscriptionProducts.value = jsonResponse.toList();
      } else {
        throw Exception('Gagal memuat data produk langganan.');
      }
    } catch (e) {
      print('Gagal memuat data produk langganan. {$e}');
    }
  }

  Future<void> fetchLatestProducts() async {
    try {
      var apiUrl = "${Api.baseUrl}/user/products/latest";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        latestProducts.value = jsonResponse.toList();
      } else {
        throw Exception('Gagal memuat data produk terbaru.');
      }
    } catch (e) {
      print('Gagal memuat data produk terbaru. {$e}');
    }
  }

  Future<void> fetchPopularProducts() async {
    try {
      var apiUrl = "${Api.baseUrl}/user/products/popular";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        popularProducts.value = jsonResponse.toList();
      } else {
        throw Exception('Gagal memuat data produk terbaru.');
      }
    } catch (e) {
      print('Gagal memuat data produk terbaru. {$e}');
    }
  }

  Future<void> fetchCategories() async {
    try {
      var apiUrl = "${Api.baseUrl}/user/categories";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        categories.value = jsonResponse.toList();
      } else {
        throw Exception('Gagal memuat data produk terbaru.');
      }
    } catch (e) {
      print('Gagal memuat data produk terbaru. {$e}');
    }
  }
}
