import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'form_sewa.dart';
import 'list_sewa.dart';
import 'model/daftar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ListKontakPage(),
    );
  }
}
