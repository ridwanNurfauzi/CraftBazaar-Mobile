import 'dart:convert';

import 'package:craftbazaar/app/providers/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var email = ''.obs;
  var password = ''.obs;

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

  void onEmailChanged(String value) {
    email.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  Future<void> login() async {
    try {
      var response = await _performLogin();
      var responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['token'] != null) {
        _saveUserData(responseBody);
        Get.snackbar('Login Berhasil', '');
        Get.offAllNamed('/navigator');
      } else
        Get.snackbar('Error', 'Login Gagal');
    } catch (err) {
      print('Error: $err');
    }
  }

  Future<http.Response> _performLogin() async {
    var apiUrl = '/user/login';
    var requestBody = <String, String>{
      'email': email.value,
      'password': password.value,
    };

    final uri = Uri.parse(Api.baseUrl + apiUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll(requestBody);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  void _saveUserData(Map<String, dynamic> responseBody) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', responseBody['token']);
  }

  void goToRegister() {
    Get.toNamed('/register');
  }
}
