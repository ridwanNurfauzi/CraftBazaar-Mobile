import 'dart:convert';

import 'package:craftbazaar/app/data/models/seller.dart';
import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class SellerController extends GetxController {
  var seller = Seller().obs;
  var tab = 0.obs;

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

  Future<void> fetchSeller(code) async {
    try {
      var token = await getToken();
      if (token == null) throw Exception('Token tidak ditemukan.');

      var apiUrl = "${Api.baseUrl}/user/sellers/code/$code";

      var headers = {
        'Authorization': 'Bearer $token',
      };

      var response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        seller.value = Seller.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('Gagal memuat data penjual.');
      }
    } catch (e) {
      print('Gagal memuat data penjual. {$e}');
    }
  }

  Future<bool> isLoggedin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString('token');

    return token != null;
  }

  Future<void> subscribe(seller_id) async {
    try {
      var token = await getToken();
      if (token == null) throw Exception('Token tidak ditemukan.');

      var apiUrl = '/user/sellers/subscribe';
      var requestBody = <String, String>{
        'seller_id': seller_id.toString(),
      };

      final uri = Uri.parse(Api.baseUrl + apiUrl);
      var request = http.MultipartRequest('post', uri);
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields.addAll(requestBody);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
    } catch (e) {
      print("Error $e");
    }
  }
}
