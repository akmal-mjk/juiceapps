import 'package:flutter/material.dart';
import 'package:juiceapps/models/stock_model.dart';
import 'package:juiceapps/pages/stock/detailscreen.dart';
import 'package:juiceapps/pages/stock/form_stock_page.dart';
import 'package:juiceapps/pages/widgets/navigator_stock.dart';
import 'package:juiceapps/services/stock_service.dart';

class stockPages extends StatefulWidget {
  const stockPages({Key? key}) : super(key: key);

  @override
  State<stockPages> createState() => _stockPagesState();
}

class _stockPagesState extends State<stockPages> {
  late Future<List<Stock>> listStock;
  final StockService = StockApi();

  @override
  void initState() {
    super.initState();
    listStock = StockService.fetchStocks();
  }

  void refreshStocks() {
    setState(() {
      listStock = StockService.fetchStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Stock Bahan'),
        backgroundColor: const Color.fromARGB(255, 253, 211, 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-stock'),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Stock>>(
            future: listStock,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Stock> isiStock = snapshot.data!;
                return ListView.builder(
                  itemCount: isiStock.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      stocks: isiStock[index],
                                    )));
                      },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(isiStock[index].nama,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.blueAccent)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text('Stock : ${isiStock[index].qty}'),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StockFormPage(
                                          stock: isiStock[index],
                                        ),
                                      ),
                                    ).then((_) => refreshStocks());
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    bool response =
                                        await StockService.deleteStock(
                                            isiStock[index].id);
                                    if (response == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.green,
                                        content:
                                            Text("Produk berhasil dihapus"),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text("Produk gagal dihapus"),
                                        ),
                                      );
                                    }
                                    refreshStocks();
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      bottomNavigationBar: const StockBottomBar(),
    );
  }
}
