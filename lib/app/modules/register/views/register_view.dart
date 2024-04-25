// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  RegisterController registerCtrl = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: "Masukkan E-mail . . .",
                    ),
                    onChanged: (value) {
                      registerCtrl.email.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Depan',
                      hintText: "Masukkan Nama depan . . .",
                    ),
                    onChanged: (value) {
                      registerCtrl.firstname.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Belakang',
                      hintText: "Masukkan Nama belakang . . .",
                    ),
                    onChanged: (value) {
                      registerCtrl.lastname.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: "Masukkan Password . . .",
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (value) {
                      registerCtrl.password.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
                      hintText: "Konfirmasi Password . . .",
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (value) {
                      registerCtrl.confirm_password.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        registerCtrl.goToLogin();
                      },
                      child: Text(
                        "Sudah Punya akun?",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      registerCtrl.register();
                    },
                    child: Text('Kirim'),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  // Obx(() => Text(
                  //     "${registerCtrl.email}, ${registerCtrl.firstname}, ${registerCtrl.lastname}, ${registerCtrl.password}"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
