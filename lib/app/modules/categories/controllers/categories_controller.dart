import 'dart:convert';

import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;

  final x = true.obs;

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

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      var apiUrl = "${Api.baseUrl}/user/categories";

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body)['data'];
        categories.value = jsonResponse.toList();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Gagal memuat data kategori.');
      }
    } catch (e) {
      isLoading.value = false;
      print('Gagal memuat data kategori. {$e}');
    }
  }
}
