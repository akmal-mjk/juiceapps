import 'package:flutter/material.dart';
import 'package:juiceapps/models/product_model.dart';
import 'package:juiceapps/pages/product/detailscreen.dart';
import 'package:juiceapps/pages/product/form_product_page.dart';
import 'package:juiceapps/pages/widgets/navigator_product.dart';
import 'package:juiceapps/services/product_service.dart';

class productPages extends StatefulWidget {
  const productPages({Key? key}) : super(key: key);

  @override
  State<productPages> createState() => _productPagesState();
}

class _productPagesState extends State<productPages> {
  late Future<List<Product>> listProduct;
  final ProductService = ProductApi();

  @override
  void initState() {
    super.initState();
    listProduct = ProductService.fetchProducts();
  }

  void refreshProducts() {
    setState(() {
      listProduct = ProductService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Juice'),
        backgroundColor: const Color.fromARGB(255, 253, 211, 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-product'),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Product>>(
            future: listProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> isiProduct = snapshot.data!;
                return ListView.builder(
                  itemCount: isiProduct.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      products: isiProduct[index],
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
                                  child: Text(isiProduct[index].nama,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.blueAccent)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                      'Harga : Rp ${isiProduct[index].price}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child:
                                      Text('Stock : ${isiProduct[index].qty}'),
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
                                        builder: (context) => ProductFormPage(
                                          product: isiProduct[index],
                                        ),
                                      ),
                                    ).then((_) => refreshProducts());
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    bool response =
                                        await ProductService.deleteProduct(
                                            isiProduct[index].id);
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
                                    refreshProducts();
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
      bottomNavigationBar: const ProductBottomBar(),
    );
  }
}
