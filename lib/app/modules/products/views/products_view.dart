// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new, avoid_print, non_constant_identifier_names, unnecessary_null_comparison

import 'package:craftbazaar/app/components/product_card1.dart';
import 'package:craftbazaar/app/data/models/products.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({Key? key}) : super(key: key);

  ProductsController productsCtrl = ProductsController();
  @override
  Widget build(BuildContext context) {
    switch (productsCtrl.dropdownValue.value) {
      case 'latest':
        productsCtrl.fetchLatestProducts();
        break;
      case 'popular':
        productsCtrl.fetchPopularProducts();
        break;
      case 'earliest':
        productsCtrl.fetchEarliestProducts();
        break;
      default:
        productsCtrl.fetchProducts();
    }

    return SafeArea(
      child: Obx(() {
        if (productsCtrl.isLoading.value)
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        else if (productsCtrl.products.length > 0)
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Produk',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Container(
                        child: DropdownButton(
                          value: productsCtrl.dropdownValue.value,
                          items: [
                            DropdownMenuItem(
                                child: Text("Terbaru"), value: 'latest'),
                            DropdownMenuItem(
                                child: Text("Terpopuler"), value: 'popular'),
                            DropdownMenuItem(
                                child: Text("Terlama"), value: 'earliest'),
                          ],
                          onChanged: (value) async {
                            if (value is String) {
                              productsCtrl.dropdownValue.value = value;
                              switch (productsCtrl.dropdownValue.value) {
                                case 'latest':
                                  await productsCtrl.fetchLatestProducts();
                                  break;
                                case 'popular':
                                  await productsCtrl.fetchPopularProducts();
                                  break;
                                case 'earliest':
                                  await productsCtrl.fetchEarliestProducts();
                                  break;
                                default:
                                  await productsCtrl.fetchProducts();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Wrap(
                    children: List.generate(
                      productsCtrl.products.length,
                      (index) => ProductCard1(
                        data: Products.fromJson(productsCtrl.products[index]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        else
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text("Tidak ada produk yang tersedia."),
            ),
          );
      }),
    );
  }
}
