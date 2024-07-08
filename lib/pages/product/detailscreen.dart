import 'package:flutter/material.dart';
import 'package:juiceapps/models/product_model.dart';

class DetailScreen extends StatelessWidget {
  final Product products;

  const DetailScreen({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products.nama),
        backgroundColor: const Color.fromARGB(255, 253, 211, 0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Center(
            child: Text(
              products.nama,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 20),
          Text('Harga: Rp ${products.price}'),
          Text("Stock: ${products.qty}"),
          Text("berat: ${products.weight} ${products.attr} "),
        ],
      ),
    );
  }
}
