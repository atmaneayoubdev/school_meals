import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:school_meals/cart_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: Text(
          "Orders",
          style: GoogleFonts.cairo(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
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
                  Get.to(const CartView());
                },
              ),
              const Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.shop,
                  color: Colors.brown,
                ),
                title: Text(
                  "Orders",
                  style: GoogleFonts.cairo(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ],
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Pending orders',
            style: GoogleFonts.tajawal(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.data != null) {
                  log(streamSnapshot.data!.docs.length.toString());

                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              spreadRadius: 5,
                              color: Colors.black12),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'cafe  ' +
                                    streamSnapshot.data!.docs[index]
                                        .get("cofe"),
                                style: GoogleFonts.tajawal(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'croissant  ' +
                                    streamSnapshot.data!.docs[index]
                                        .get("croissant"),
                                style: GoogleFonts.tajawal(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'water  ' +
                                    streamSnapshot.data!.docs[index]
                                        .get("water"),
                                style: GoogleFonts.tajawal(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'juice  ' +
                                    streamSnapshot.data!.docs[index]
                                        .get("juice"),
                                style: GoogleFonts.tajawal(
                                    fontSize: 20,
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              streamSnapshot.data!.docs[index].reference
                                  .delete();
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.trash,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text("empty");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
