// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls

import 'package:craftbazaar/app/data/models/product.dart';
import 'package:craftbazaar/app/providers/api.dart';
import 'package:craftbazaar/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_controller.dart';

import '../../../helpers/size_helper.dart';

class ProductView extends GetView<ProductController> {
  ProductView({Key? key}) : super(key: key);
  ProductController productCtrl = ProductController();

  final slug = Get.arguments['slug'];

  double averageRating() {
    var ratings = productCtrl.product.value.reviews?.toList();
    double average = 0;
    if (ratings!.length > 0) {
      double total = 0;
      ratings.forEach((el) {
        total += el.rating!.toDouble();
      });

      average = total / ratings.length;
    }
    return average;
  }

  List<StatelessWidget> ratings = [];

  void productRateToRatings() {
    const starFill = Icon(
      Icons.star,
      size: 22,
      color: Color(0xFFE5DA02),
    );
    const starHalf = Icon(
      Icons.star_half,
      size: 22,
      color: Color(0xFFE5DA02),
    );
    const star = Icon(
      Icons.star_outline,
      size: 22,
      color: Color(0xFFE5DA02),
    );
    var val = averageRating();
    ratings = [];
    for (var i = 0; i <= 4; i++) {
      if (val - i >= 0.75) {
        ratings.add(starFill);
      } else if (val - i >= 0.25) {
        ratings.add(starHalf);
      } else {
        ratings.add(star);
      }
    }
    ratings.add(Text(
        "${averageRating().toStringAsFixed(2)} / ${productCtrl.product.value.reviews!.length}"));
  }

  List<StatelessWidget> rateToStars(int num) {
    List<StatelessWidget> stars = [];
    const starFill = Icon(
      Icons.star,
      size: 16,
      color: Color(0xFFE5DA02),
    );
    const starHalf = Icon(
      Icons.star_half,
      size: 16,
      color: Color(0xFFE5DA02),
    );
    const star = Icon(
      Icons.star_outline,
      size: 16,
      color: Color(0xFFE5DA02),
    );
    var val = num;
    stars = [];
    for (var i = 0; i <= 4; i++) {
      if (val - i >= 0.75) {
        stars.add(starFill);
      } else if (val - i >= 0.25) {
        stars.add(starHalf);
      } else {
        stars.add(star);
      }
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    productCtrl.fetchProductBySlug(slug).then((value) {
      productRateToRatings();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (productCtrl.isLoading.value)
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            else if (productCtrl.product.value.name != null)
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: displayWidth(context),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          productCtrl.product.value.productImages!.length,
                          (index) => Container(
                            width: displayWidth(context),
                            margin: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${Api.baseUrl}/public/images/products/${productCtrl.product.value.productImages![index].filename}"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Center(
                      child: Text(
                        "${productCtrl.product.value.name}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.SELLER, arguments: {
                            "code": productCtrl.product.value.seller!.code
                                .toString()
                          });
                        },
                        child: Text(
                          "${productCtrl.product.value.seller!.name}",
                          style: TextStyle(color: Color(0xFF505050)),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Text('Kategori'),
                          ),
                          Expanded(
                            child: Wrap(
                              children: List.generate(
                                productCtrl.product.value.categories!.length,
                                (index) => InkWell(
                                  onTap: () {
                                    Get.toNamed('/products-by-category',
                                        arguments: {
                                          'category': productCtrl.product.value
                                              .categories![index].name
                                              .toString()
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 97, 97, 97),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      '${productCtrl.product.value.categories![index].name}',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "${productCtrl.product.value.description}",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: ratings,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: List.generate(
                          productCtrl.product.value.showedReviews!.length,
                          (index) => Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          productCtrl
                                                      .product
                                                      .value
                                                      .reviews![index]
                                                      .user!
                                                      .photo !=
                                                  null
                                              ? "${Api.baseUrl}/public/images/profiles/user/${productCtrl.product.value.reviews![index].user!.photo}"
                                              : '${Api.baseUrl}/public/images/profiles/user/dummy.png',
                                        ),
                                        opacity: 1,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          "${productCtrl.product.value.showedReviews![index].user!.firstname} ${productCtrl.product.value.showedReviews![index].user!.lastname}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                            children: rateToStars(productCtrl
                                                    .product
                                                    .value
                                                    .showedReviews![index]
                                                    .rating is int
                                                ? productCtrl
                                                    .product
                                                    .value
                                                    .showedReviews![index]
                                                    .rating as int
                                                : 0)),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                            "${productCtrl.product.value.showedReviews![index].text}"),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                  ],
                ),
              );
            else
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Text("Produk tidak ditemukan."),
                ),
              );
          },
        ),
      ),
    );
  }
}
