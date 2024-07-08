import 'package:flutter/material.dart';
import 'package:juiceapps/services/product_service.dart';
import 'package:juiceapps/models/product_model.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final ProductApi productApi = ProductApi();

  final _namaController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _namaController.text = widget.product!.nama;
      _priceController.text = widget.product!.price.toString();
      _qtyController.text = widget.product!.qty.toString();
      _attrController.text = widget.product!.attr;
      _weightController.text = widget.product!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk')),
        backgroundColor: const Color.fromARGB(255, 253, 211, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama produk';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan harga produk';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(labelText: 'Kuantitas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kuantitas produk';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _attrController,
                decoration: const InputDecoration(labelText: 'Atribut'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan atribut produk';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Berat'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan berat produk';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.product == null) {
                      // Tambah produk baru
                      response = await productApi.createProduct(
                        _namaController.text,
                        num.parse(_priceController.text),
                        num.parse(_qtyController.text),
                        _attrController.text,
                        num.parse(_weightController.text),
                      );
                    } else {
                      // Update produk yang ada
                      response = await productApi.updateProduct(
                        Product(
                          id: widget.product!.id,
                          nama: _namaController.text,
                          price: num.parse(_priceController.text),
                          qty: num.parse(_qtyController.text),
                          attr: _attrController.text,
                          weight: num.parse(_weightController.text),
                        ),
                        widget.product!.id,
                      );
                    }

                    if (response == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.product == null
                            ? "Produk berhasil ditambahkan"
                            : "Produk berhasil diperbarui"),
                      ));
                      Navigator.of(context).popAndPushNamed('/product');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.product == null
                            ? "Produk gagal ditambahkan"
                            : "Produk gagal diperbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.product == null ? 'Simpan' : 'Update',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
