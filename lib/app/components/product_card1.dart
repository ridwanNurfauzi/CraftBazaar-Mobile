// ignore_for_file: prefer_const_constructors, prefer_is_empty, avoid_unnecessary_containers, must_be_immutable, unnecessary_overrides, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, sort_child_properties_last, unused_import, avoid_function_literals_in_foreach_calls, unnecessary_string_interpolations, unnecessary_new

import 'package:craftbazaar/app/data/models/products.dart';
import 'package:craftbazaar/app/providers/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

final rupiah = new NumberFormat.simpleCurrency(locale: 'id_ID');

class ProductCard1 extends StatelessWidget {
  final Products data;
  ProductCard1({
    required this.data,
    super.key,
  });

  double averageRating() {
    var ratings = data.reviews?.toList();
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

  void rateToRatings() {
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
    ratings.add(Text("${averageRating().toStringAsFixed(2)}"));
  }

  @override
  Widget build(BuildContext context) {
    rateToRatings();

    return Container(
      margin: EdgeInsets.all(5),
      width: 120,
      height: 260,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 243, 243),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Get.toNamed('/product', arguments: {'slug': data.slug.toString()});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0x00FFFFFF),
                image: DecorationImage(
                  image: NetworkImage(
                      "${Api.baseUrl}/public/images/products/${data.productImages?[0].filename}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
            Text(
              "${data.name}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "${data.seller!.name}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
            Row(
              children: ratings,
            ),
            Text(
              "${rupiah.format(double.parse(data.price.toString()))}",
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Stok: ${data.stock}",
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Terjual: ${data.sold}",
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
