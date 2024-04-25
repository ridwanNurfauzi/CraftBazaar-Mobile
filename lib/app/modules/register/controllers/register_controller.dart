// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:craftbazaar/app/providers/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var email = ''.obs;
  var firstname = ''.obs;
  var lastname = ''.obs;
  var password = ''.obs;
  var confirm_password = ''.obs;

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

  Future<void> register() async {
    try {
      var response = await _performRegister();
      var responseBody = json.decode(response.body);

      print('$responseBody');

      if (response.statusCode == 200 && responseBody['success']) {
        Get.snackbar('register Berhasil', '');
        Get.offNamed('/login');
      } else
        Get.snackbar('Error', 'Register Gagal');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<http.Response> _performRegister() async {
    var apiUrl = '/user/register';
    var requestBody = <String, String>{
      'email': email.value,
      'firstname': firstname.value,
      'lastname': lastname.value,
      'password': password.value,
      'confirm_password': confirm_password.value,
    };

    final uri = Uri.parse(Api.baseUrl + apiUrl);
    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll(requestBody);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return response;
  }

  void goToLogin() {
    Get.toNamed('/login');
  }
}
