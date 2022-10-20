import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/daftar.dart';


class FormKontak extends StatefulWidget {
  final Kontak? kontak;

  FormKontak({this.kontak});

  @override
  _FormKontakState createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  DbHelper db = DbHelper();

  TextEditingController? Nama;
  TextEditingController? lastName;
  TextEditingController? notelp;
  TextEditingController? Peminjaman;
  TextEditingController? Pengembalian;
  TextEditingController? Jaminan;

  @override
  void initState() {
    Nama = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.Nama);

    notelp = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.notelp);

    Peminjaman = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.Peminjaman);

    Pengembalian = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.Pengembalian);

    Jaminan = TextEditingController(
        text: widget.kontak == null ? '' : widget.kontak!.Jaminan);
        
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Penyewaan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: Nama,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: notelp,
              decoration: InputDecoration(
                  labelText: 'No Telp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: Peminjaman,
              decoration: InputDecoration(
                  labelText: 'Tanggal Peminjaman',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: Pengembalian,
              decoration: InputDecoration(
                  labelText: 'Tanggal Pengembalian',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
            Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: Jaminan,
              decoration: InputDecoration(
                  labelText: 'Jaminan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20
            ),
            child: ElevatedButton(
              child: (widget.kontak == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
              onPressed: () {
                upsertKontak();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertKontak() async {
    if (widget.kontak != null) {
      await db.updateKontak(Kontak(
        id: widget.kontak!.id, 
        Nama: Nama!.text, 
        notelp: notelp!.text, 
        Peminjaman: Peminjaman!.text, 
        Pengembalian: Pengembalian!.text,
        Jaminan: Jaminan!.text
      ));

      Navigator.pop(context, 'update');
    } else {
      await db.saveKontak(Kontak(
        Nama: Nama!.text,
        notelp: notelp!.text,
        Peminjaman: Peminjaman!.text,
        Pengembalian: Pengembalian!.text,
        Jaminan: Jaminan!.text
      ));
      Navigator.pop(context, 'save');
    }
  }
}