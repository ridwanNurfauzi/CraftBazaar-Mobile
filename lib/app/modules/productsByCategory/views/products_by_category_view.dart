// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls

import 'package:craftbazaar/app/components/product_card1.dart';
import 'package:craftbazaar/app/data/models/products.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/products_by_category_controller.dart';

class ProductsByCategoryView extends GetView<ProductsByCategoryController> {
  ProductsByCategoryView({Key? key}) : super(key: key);

  ProductsByCategoryController productCtrl = ProductsByCategoryController();

  final category = Get.arguments['category'];

  @override
  Widget build(BuildContext context) {
    productCtrl.fetchProductsByCategory(category);

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
      body: SafeArea(
        child: Obx(() {
          if (productCtrl.isLoading.value)
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          else if (productCtrl.products.length > 0)
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        'Kategori $category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Wrap(
                      children: List.generate(
                        productCtrl.products.length,
                        (index) => ProductCard1(
                          data: Products.fromJson(
                              productCtrl.products[index]['product']),
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
      ),
    );
  }
}
