import 'package:flutter/material.dart';
import 'form_sewa.dart';
import 'database/db_helper.dart';
import 'model/daftar.dart';

class ListKontakPage extends StatefulWidget {
  const ListKontakPage({ Key? key }) : super(key: key);

  @override
  _ListKontakPageState createState() => _ListKontakPageState();
}

class _ListKontakPageState extends State<ListKontakPage> {
  List<Kontak> listKontak = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
  
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          title: Center(
            child: Text("SM MADURA"),
          ),
        ),
        body: ListView.builder(
            itemCount: listKontak.length,
            itemBuilder: (context, index) {
              Kontak kontak = listKontak[index];
              return Padding(
                padding: const EdgeInsets.only(
                  top: 20
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.person, 
                    size: 50,
                  ),
                  title: Text(
                    '${kontak.Nama}'
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8, 
                        ),
                        child: Text("No Telp: ${kontak.notelp}"),
                      ), 
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Tanggal Peminjaman: ${kontak.Peminjaman}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Tanggal Pengembalian: ${kontak.Pengembalian}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Text("Jaminan: ${kontak.Jaminan}"),
                      )
                    ],
                  ),
                  trailing: 
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _openFormEdit(kontak);
                          },
                          icon: Icon(Icons.edit)
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (){
                            AlertDialog hapus = AlertDialog(
                              title: Text("Information"),
                              content: Container(
                                height: 100, 
                                child: Column(
                                  children: [
                                    Text(
                                      "Yakin ingin Menghapus Data ${kontak.Nama}"
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    _deleteKontak(kontak, index);
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("Ya")
                                ), 
                                TextButton(
                                  child: Text('Tidak'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                            showDialog(context: context, builder: (context) => hapus);
                          }, 
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add), 
              onPressed: (){
                _openFormCreate();
              },
            ),
      
    );
  }

  Future<void> _getAllKontak() async {
    var list = await db.getAllKontak();

    setState(() {
      listKontak.clear();

      list!.forEach((kontak) {
        
        listKontak.add(kontak);
      });
    });
  }

  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormKontak()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}