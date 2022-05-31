import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:school_meals/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/my_drawer.dart';
import '../controllers/items_controller.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final CartController cart = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).primaryColor,
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
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      drawer: const MyDrawer(type: 'cart'),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Color.fromARGB(112, 19, 61, 123),
                      )
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ListTile(
                          leading: Text(
                            "كوكيز",
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
                                  color: Theme.of(context).primaryColor),
                            ),
                          )),
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
                                  color: Theme.of(context).primaryColor),
                            ),
                          )),
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
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
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
                                  color: Theme.of(context).primaryColor),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  db
                      .collection('users')
                      .add({
                        'cookies': cart.cookiesCount.toString(),
                        'croissant': cart.croissantCount.toString(),
                        'coffe': cart.cofeCount.toString(),
                        'water': cart.waterCount.toString(),
                      })
                      .then(
                        (DocumentReference doc) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم ارسال طلبك بنجاح',
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor:
                                const Color.fromRGBO(19, 61, 123, 1),
                          ),
                        ),
                      )
                      .then((value) {
                        setState(() {
                          isLoading = false;
                        });

                        Get.delete<CartController>()
                            .then((value) => Get.to(const HomeView()));
                      });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Color.fromARGB(112, 19, 61, 123),
                      )
                    ],
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'ارسال الطلب',
                    style: GoogleFonts.tajawal(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
