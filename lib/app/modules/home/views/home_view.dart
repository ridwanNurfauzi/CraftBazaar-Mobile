// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new

import 'package:craftbazaar/app/components/category_card.dart';
import 'package:craftbazaar/app/components/product_card.dart';
import 'package:craftbazaar/app/data/models/products.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final bool isLoggedin;
  HomeView({
    required this.isLoggedin,
    Key? key,
  }) : super(key: key);

  HomeController homeCtrl = HomeController();

  @override
  Widget build(BuildContext context) {
    homeCtrl.fetchLatestProducts();
    homeCtrl.fetchSubscriptionProducts();
    homeCtrl.fetchPopularProducts();
    homeCtrl.fetchCategories();

    StatelessWidget _subscriptionProducts() {
      if (isLoggedin) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Langganan',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Obx(() {
                if (homeCtrl.subscriptionProducts.length < 1) {
                  return Container(
                    height: 100,
                    color: Color.fromRGBO(247, 247, 247, 0.298),
                    child:
                        Center(child: Text("Anda belum memiliki langganan.")),
                  );
                } else {
                  return Container(
                    height: 260,
                    color: Color.fromRGBO(247, 247, 247, 0.298),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        homeCtrl.subscriptionProducts.length,
                        (index) => ProductCard(
                          data: Products.fromJson(
                            homeCtrl.subscriptionProducts[index],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        );
      } else {
        return Container();
      }
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/main-bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text(
                  'Beranda',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            _subscriptionProducts(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Terbaru',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Obx(() {
              if (homeCtrl.latestProducts.length < 1) {
                return Container(
                  height: 100,
                  color: Color.fromRGBO(247, 247, 247, 0.298),
                  child: Center(child: Text("Tidak Ada Produk Terbaru.")),
                );
              } else {
                return Container(
                  height: 260,
                  color: Color.fromRGBO(247, 247, 247, 0.298),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      homeCtrl.latestProducts.length,
                      (index) => ProductCard(
                        data: Products.fromJson(
                          homeCtrl.latestProducts[index],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Terpopuler',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Obx(
              () {
                if (homeCtrl.popularProducts.length < 1) {
                  return Container(
                    height: 100,
                    color: Color.fromRGBO(247, 247, 247, 0.298),
                    child: Center(child: Text("Tidak Ada Produk Terpopuler.")),
                  );
                } else {
                  return Container(
                    height: 260,
                    color: Color.fromRGBO(247, 247, 247, 0.298),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        homeCtrl.popularProducts.length,
                        (index) => ProductCard(
                          data: Products.fromJson(
                              homeCtrl.popularProducts[index]),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Kategori',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Obx(
              () {
                if (homeCtrl.popularProducts.length < 1) {
                  return Container(
                    height: 100,
                    color: Color.fromRGBO(247, 247, 247, 0.298),
                    child: Center(child: Text("Tidak Ada Produk Terpopuler.")),
                  );
                } else {
                  return Container(
                    height: 70,
                    color: Color.fromRGBO(247, 247, 247, 0.298),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        homeCtrl.categories.length,
                        (index) => CategoryCard(
                          data: Categories.fromJson(homeCtrl.categories[index]),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
          ],
        ),
      ),
    );
  }
}
