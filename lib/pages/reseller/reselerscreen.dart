import 'package:flutter/material.dart';
import 'package:juiceapps/models/reseler_model.dart';
import 'package:juiceapps/pages/reseller/detailscreen.dart';
import 'package:juiceapps/pages/reseller/form_reseler_page.dart';
import 'package:juiceapps/pages/widgets/navigator_reseler.dart';
import 'package:juiceapps/services/reseler_service.dart';

class reselerPages extends StatefulWidget {
  const reselerPages({Key? key}) : super(key: key);

  @override
  State<reselerPages> createState() => _reselerPagesState();
}

class _reselerPagesState extends State<reselerPages> {
  late Future<List<Reseler>> listReseler;
  final ReselerService = ReselerApi();

  @override
  void initState() {
    super.initState();
    listReseler = ReselerService.fetchReselers();
  }

  void refreshReselers() {
    setState(() {
      listReseler = ReselerService.fetchReselers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Reseler'),
        backgroundColor: const Color.fromARGB(255, 253, 211, 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).popAndPushNamed('/add-reseler'),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Reseler>>(
            future: listReseler,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Reseler> isiReseler = snapshot.data!;
                return ListView.builder(
                  itemCount: isiReseler.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      reselers: isiReseler[index],
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
                                  child: Text(isiReseler[index].buyer,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.blueAccent)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  child: Text(
                                      'Status : ${isiReseler[index].status}'),
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
                                        builder: (context) => ReselerFormPage(
                                          reseler: isiReseler[index],
                                        ),
                                      ),
                                    ).then((_) => refreshReselers());
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    bool response =
                                        await ReselerService.deleteReseler(
                                            isiReseler[index].id);
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
                                    refreshReselers();
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
      bottomNavigationBar: const ReselerBottomBar(),
    );
  }
}
