import 'package:flutter/material.dart';
import 'package:juiceapps/models/stock_model.dart';

class DetailScreen extends StatelessWidget {
  final Stock stocks;

  const DetailScreen({Key? key, required this.stocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stocks.nama),
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
              stocks.nama,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blueAccent),
            ),
          ),
          const SizedBox(height: 20),
          Text("Stock: ${stocks.qty}"),
          Text("berat: ${stocks.weight} ${stocks.attr} "),
        ],
      ),
    );
  }
}
