// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, sized_box_for_whitespace, must_be_immutable

import 'package:craftbazaar/app/components/product_card1.dart';
import 'package:craftbazaar/app/data/models/products.dart';
import 'package:craftbazaar/app/middlewares/auth_middleware.dart';
import 'package:craftbazaar/app/providers/api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seller_controller.dart';

class SellerView extends GetView<SellerController> {
  SellerView({Key? key}) : super(key: key);

  SellerController sellerCtrl = SellerController();

  final code = Get.arguments['code'];

  @override
  Widget build(BuildContext context) {
    sellerCtrl.fetchSeller(code);

    Widget subscribeBtn() {
      return FutureBuilder(
        future: sellerCtrl.isLoggedin(),
        builder: (context, snapshot) {
          return InkWell(
            onTap: () {
              if (snapshot.data == true) {
                sellerCtrl
                    .subscribe(sellerCtrl.seller.value.id)
                    .then((value) => sellerCtrl.fetchSeller(code));
              } else {
                Get.snackbar('Akses ditolak.', 'Anda harus login dulu.');
                AuthMiddleware().redirect('');
              }
            },
            child: Obx(
              () => Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  sellerCtrl.seller.value.subscribed == true
                      ? "Berhenti berlangganan"
                      : "Jadikan Langganan",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      );
    }

    StatelessWidget sellerTab() {
      BoxDecoration activeBorder = BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.blueAccent,
          ),
        ),
      );

      TextStyle activeText = TextStyle(color: Colors.blueAccent);

      return Container(
        width: double.infinity,
        child: Obx(
          () => Row(
            children: [
              Expanded(
                child: Container(
                  decoration: sellerCtrl.tab.value == 0
                      ? activeBorder
                      : BoxDecoration(),
                  child: InkWell(
                    onTap: () {
                      sellerCtrl.tab.value = 0;
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Produk",
                          style: sellerCtrl.tab.value == 0
                              ? activeText
                              : TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: sellerCtrl.tab.value == 1
                      ? activeBorder
                      : BoxDecoration(),
                  child: InkWell(
                    onTap: () {
                      sellerCtrl.tab.value = 1;
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          "Deskripsi",
                          style: sellerCtrl.tab.value == 1
                              ? activeText
                              : TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    StatelessWidget shownTabPage() {
      if (sellerCtrl.tab.value == 0)
        return Container(
          margin: EdgeInsets.all(10),
          child: Wrap(
            children: List.generate(
              sellerCtrl.seller.value.products!.length,
              (index) => ProductCard1(
                data: Products.fromJson(
                    sellerCtrl.seller.value.products![index].toJson()),
              ),
            ),
          ),
        );
      else
        return Container(
          padding: EdgeInsets.all(10),
          child: Obx(() {
            return Text(
              "${sellerCtrl.seller.value.description}",
              textAlign: TextAlign.justify,
            );
          }),
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Penjual'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (sellerCtrl.seller.value.name != null)
              return SingleChildScrollView(
                child: Column(
                  children: [
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
                                sellerCtrl.seller.value.photo != null
                                    ? '${Api.baseUrl}/public/images/profiles/seller/${sellerCtrl.seller.value.photo}'
                                    : '${Api.baseUrl}/public/images/profiles/user/dummy.png',
                              ),
                              opacity: 1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${sellerCtrl.seller.value.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    subscribeBtn(),
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "${sellerCtrl.seller.value.subscribers!.length} Pelanggan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "${sellerCtrl.seller.value.products!.length} Produk",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    sellerTab(),
                    Padding(padding: EdgeInsets.all(10)),
                    shownTabPage(),
                  ],
                ),
              );
            else
              return Container();
          },
        ),
      ),
    );
  }
}
