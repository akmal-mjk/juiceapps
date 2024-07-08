import 'package:flutter/material.dart';
import 'package:juiceapps/services/stock_service.dart';
import 'package:juiceapps/models/stock_model.dart';

class StockFormPage extends StatefulWidget {
  final Stock? stock;

  const StockFormPage({super.key, this.stock});

  @override
  // ignore: library_private_types_in_public_api
  _StockFormPageState createState() => _StockFormPageState();
}

class _StockFormPageState extends State<StockFormPage> {
  final StockApi stockApi = StockApi();

  final _namaController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.stock != null) {
      _namaController.text = widget.stock!.nama;
      _qtyController.text = widget.stock!.qty.toString();
      _attrController.text = widget.stock!.attr;
      _weightController.text = widget.stock!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(widget.stock == null ? 'Tambah Stock' : 'Edit Stock')),
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
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama stock';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: InputDecoration(labelText: 'Kuantitas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kuantitas stock';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _attrController,
                decoration: InputDecoration(labelText: 'Atribut'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan atribut stock';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Berat'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan berat stock';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.stock == null) {
                      // Tambah stock baru
                      response = await stockApi.createStock(
                        _namaController.text,
                        num.parse(_qtyController.text),
                        _attrController.text,
                        num.parse(_weightController.text),
                      );
                    } else {
                      // Update stock yang ada
                      response = await stockApi.updateStock(
                        Stock(
                          id: widget.stock!.id,
                          nama: _namaController.text,
                          qty: num.parse(_qtyController.text),
                          attr: _attrController.text,
                          weight: num.parse(_weightController.text),
                        ),
                        widget.stock!.id,
                      );
                    }

                    if (response == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.stock == null
                            ? "Produk berhasil ditambahkan"
                            : "Produk berhasil diperbarui"),
                      ));
                      Navigator.of(context).popAndPushNamed('/stock');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.stock == null
                            ? "Produk gagal ditambahkan"
                            : "Produk gagal diperbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.stock == null ? 'Simpan' : 'Update',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
