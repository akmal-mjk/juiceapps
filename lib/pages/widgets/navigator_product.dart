import 'package:flutter/material.dart';
import 'package:juiceapps/pages/product/homescreen.dart';
import 'package:juiceapps/pages/reseller/reselerscreen.dart';
import 'package:juiceapps/pages/stock/stockscreen.dart';


class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(247, 255, 169, 9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const productPages(),
                ));
          },
          child: const Icon(
            Icons.production_quantity_limits,
            color: Colors.white,
            size: 35,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const reselerPages(),
                ));
          },
          child: const Icon(
            Icons.person,
            color: Colors.black,
            size: 35,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const stockPages(),
                ));
          },
          child: const Icon(
            Icons.storage,
            color: Colors.black,
            size: 35,
          ),
        ),
      ]),
    );
  }
}
