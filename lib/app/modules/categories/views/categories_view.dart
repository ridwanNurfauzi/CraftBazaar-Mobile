// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new

import 'package:craftbazaar/app/components/category_card.dart';
import 'package:craftbazaar/app/data/models/products.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  CategoriesView({Key? key}) : super(key: key);

  CategoriesController categoriesCtrl = CategoriesController();

  @override
  Widget build(BuildContext context) {
    categoriesCtrl.fetchCategories();

    return SafeArea(child: Obx(() {
      if (categoriesCtrl.isLoading.value)
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      else if (categoriesCtrl.x.value)
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Text(
                    'Kategory',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                margin: EdgeInsets.all(10),
                child: Wrap(
                  children: List.generate(
                    categoriesCtrl.categories.length,
                    (index) => CategoryCard(
                      data: Categories.fromJson(
                        categoriesCtrl.categories[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      else
        return Container();
    }));
  }
}
