import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:school_meals/home_view.dart';

import 'items_controller.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final CartController cart = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: Text(
          "السلة",
          style: GoogleFonts.cairo(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.delete<CartController>()
                  .then((value) => Get.to(const HomeView()));
            },
            child: Center(
              child: Text(
                "افراغ السلة",
                style: GoogleFonts.cairo(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.red),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          width: _size.width * 0.8,
          color: Colors.white,
          child: Column(
            children: [
              Text(
                "مدرستي",
                style: GoogleFonts.cairo(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.brown,
                ),
                title: Text(
                  "الرئيسية",
                  style: GoogleFonts.cairo(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Get.to(const HomeView());
                },
              ),
              const Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.brown,
                ),
                title: Text(
                  "السلة",
                  style: GoogleFonts.cairo(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 5,
                  color: Colors.grey.shade300,
                )
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "قهوة",
                    style: GoogleFonts.tajawal(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  trailing: Obx(
                    () => Text(
                      "الكمية : ${cart.cofeCount}",
                      style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown),
                    ),
                  ),
                ),
                ListTile(
                    leading: Text(
                      "كروسان",
                      style: GoogleFonts.tajawal(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    trailing: Obx(
                      () => Text(
                        "الكمية : ${cart.croissantCount}",
                        style: GoogleFonts.tajawal(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.brown),
                      ),
                    )),
                ListTile(
                    leading: Text(
                      "ماء",
                      style: GoogleFonts.tajawal(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    trailing: Obx(
                      () => Text(
                        "الكمية : ${cart.waterCount}",
                        style: GoogleFonts.tajawal(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.brown),
                      ),
                    )),
                ListTile(
                  leading: Text(
                    "عصير",
                    style: GoogleFonts.tajawal(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  trailing: Obx(
                    () => Text(
                      "الكمية : ${cart.juiceCount}",
                      style: GoogleFonts.tajawal(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Center(
                    child: Text(
                      "المجموع : ${cart.total()}",
                      style: GoogleFonts.tajawal(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
