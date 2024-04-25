// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last

import 'package:craftbazaar/app/middlewares/auth_middleware.dart';
import 'package:craftbazaar/app/modules/categories/views/categories_view.dart';
import 'package:craftbazaar/app/modules/home/views/home_view.dart';
import 'package:craftbazaar/app/modules/products/views/products_view.dart';
import 'package:craftbazaar/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/navigator_controller.dart';

class NavigatorView extends GetView<NavigatorController> {
  NavigatorView({Key? key}) : super(key: key);

  NavigatorController navCtrl = NavigatorController();

  void changePage(int value) {
    if (navCtrl.pageCtrl.value.hasClients)
      navCtrl.pageCtrl.value.animateToPage(
        value,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    if (value == 3) {
      AuthMiddleware().redirect('');
    }
    navCtrl.pageCtrl.value =
        PageController(initialPage: value, keepPage: false);
    navCtrl.currentPageIndex.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: navCtrl.isLoggedin(),
      builder: (context, snapshot) {
        HomeView homePage;
        if (snapshot.data == true) {
          homePage = HomeView(isLoggedin: true);
        } else {
          homePage = HomeView(isLoggedin: false);
        }
        var pages = [
          homePage,
          ProductsView(),
          CategoriesView(),
          ProfileView(),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icon/craftbazaar.png'))),
                ),
                Text(
                  'CraftBazaar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          body: Obx(
            () => PageView(
              controller: navCtrl.pageCtrl.value,
              children: pages,
              scrollDirection: Axis.horizontal,
              onPageChanged: (int value) {
                if (value == 3) {
                  AuthMiddleware().redirect('');
                }
                navCtrl.pageCtrl.value = PageController(
                  initialPage: value,
                );
                navCtrl.currentPageIndex.value = value;
              },
            ),
          ),
          bottomNavigationBar: Obx(() => NavigationBar(
                onDestinationSelected: changePage,
                indicatorColor: Color.fromARGB(255, 1, 175, 255),
                selectedIndex: navCtrl.currentPageIndex.value,
                backgroundColor: Color.fromARGB(255, 250, 252, 255),
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Beranda',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.shopping_bag),
                    label: 'Produk',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.tag),
                    label: 'Kategori',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.account_circle),
                    label: 'Profil',
                  ),
                ],
              )),
        );
      },
    );
  }
}
