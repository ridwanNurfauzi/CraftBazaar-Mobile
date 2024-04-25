// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls

import 'package:craftbazaar/app/providers/api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  ProfileController profileCtrl = ProfileController();

  @override
  Widget build(BuildContext context) {
    profileCtrl.fetchUserDetails();

    return SafeArea(
      child: Obx(
        () {
          if (profileCtrl.profile.value.email != null)
            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 160,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            image: DecorationImage(
                              image: NetworkImage(
                                profileCtrl.profile.value.photo != null
                                    ? '${Api.baseUrl}/public/images/profiles/user/${profileCtrl.profile.value.photo}'
                                    : '${Api.baseUrl}/public/images/profiles/user/dummy.png',
                              ),
                              opacity: 1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text("${profileCtrl.profile.value.email}"),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Nama Depan",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text("${profileCtrl.profile.value.firstname}"),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        "Nama Belakang",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text("${profileCtrl.profile.value.lastname}"),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    ElevatedButton(
                      onPressed: () {
                        profileCtrl.logout();
                      },
                      child: Text("logout"),
                    )
                  ],
                ),
              ),
            );
          else
            return Container();
        },
      ),
    );
  }
}
