// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new, avoid_print, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';

import 'package:craftbazaar/app/data/models/profile.dart';
import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var isLoading = true.obs;

  var profile = Profile.fromJson({}).obs;

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.get('token').toString();
  }

  Future fetchUserDetails() async {
    var apiUrl = '/user/profile';
    try {
      var token = await getToken();
      if (token == null) throw Exception('Token tidak ditemukan.');

      var headers = {
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
        Uri.parse(Api.baseUrl + apiUrl),
        headers: headers,
      );

      var responseBody = json.decode(response.body)['data'];

      if (response.statusCode == 200) {
        profile.value = Profile.fromJson(responseBody);
      } else {
        throw Exception('Gagal memuat data user.');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchUserDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future logout() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
    } catch (e) {
      print('Error : $e');
    } finally {
      Get.offNamed('/login');
    }
  }
}
