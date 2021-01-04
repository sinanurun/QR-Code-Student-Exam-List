import 'package:flutter/material.dart';
import 'package:qrcode/views/anasayfa.dart';
import 'package:qrcode/views/ogrencieklemesayfasi.dart';
import 'package:qrcode/views/ogrencilisteleme.dart';
import 'package:qrcode/views/raporlamasayfasi.dart';
import 'package:qrcode/views/sinaveklemesayfasi.dart';
import 'package:qrcode/views/sinavlisteleme.dart';






void main() => runApp(Giris());

class Giris extends StatelessWidget {


  final appTitle = 'Öğrenci Yoklama Uygulaması';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {"/": (context) => Anasayfa(),
        "/ogrencilistesi":(context)=>Ogrencilisteleme(),
        "/ogrenciekle":(context)=>Ogrencieklemesayfasi(),
         "/sinavlistesi":(context)=>Sinavlisteleme(),
        "/sinavekle":(context)=>Sinaveklemesayfasi(),
        "/raporlar":(context)=>RaporlamaSayfasi(),
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}
