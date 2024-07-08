import 'package:flutter/material.dart';
import 'package:juiceapps/models/reseler_model.dart';
import 'package:juiceapps/services/reseler_service.dart';

class ReselerFormPage extends StatefulWidget {
  final Reseler? reseler;

  ReselerFormPage({super.key, this.reseler});

  @override
  // ignore: library_private_types_in_public_api
  _ReselerFormPageState createState() => _ReselerFormPageState();
}

class _ReselerFormPageState extends State<ReselerFormPage> {
  final ReselerApi reselerApi = ReselerApi();

  final _buyerController = TextEditingController();
  final _phnController = TextEditingController();
  final _dateController = TextEditingController();
  final _statusController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.reseler != null) {
      _buyerController.text = widget.reseler!.buyer;
      _phnController.text = widget.reseler!.phone;
      _dateController.text = widget.reseler!.date;
      _statusController.text = widget.reseler!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.reseler == null ? 'Tambah reseler' : 'Edit Reseler')),
        backgroundColor: const Color.fromARGB(255, 253, 211, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _buyerController,
                decoration: const InputDecoration(labelText: 'Buyer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan buyer';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phnController,
                decoration: const InputDecoration(labelText: 'No HP'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Nomor HP';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Tanggal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan tanggal';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan status buyer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.reseler == null) {
                      // Tambah reseler baru
                      response = await reselerApi.createReseler(
                        _buyerController.text,
                        _phnController.text,
                        _dateController.text,
                        _statusController.text,
                      );
                    } else {
                      // Update reseler yang ada
                      response = await reselerApi.updateReseler(
                        Reseler(
                          id: widget.reseler!.id,
                          buyer: _buyerController.text,
                          phone: _phnController.text,
                          date: _dateController.text,
                          status: _statusController.text,
                        ),
                        widget.reseler!.id,
                      );
                    }

                    if (response == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.reseler == null
                            ? "Buyer berhasil ditambahkan"
                            : "Buyer berhasil diperbarui"),
                      ));
                      Navigator.of(context).popAndPushNamed('/reseler');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.reseler == null
                            ? "Buyer gagal ditambahkan"
                            : "Buyer gagal diperbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.reseler == null ? 'Simpan' : 'Update',
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
