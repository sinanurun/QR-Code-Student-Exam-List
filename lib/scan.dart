import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/models/dbhelper.dart';
import 'package:qrcode/models/sinavModel.dart';
import 'package:qrcode/witgets/myDrawer.dart';

class ScanPage extends StatefulWidget {
  final Sinav sinav;

  const ScanPage(this.sinav);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Henüz Bir Tarama Gerçekleşmedi";
  String durum = "Tarama Yapılmadı";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sınav Adı : " + widget.sinav.sinav_adi),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Sınav Adı : " + widget.sinav.sinav_adi,
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Öğrenci No : " + qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              durum,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                String codeSanner = await BarcodeScanner
                    .scan(); //barcode scnner
                String sonuc = await DBHelper().oturumKontrol(
                    widget.sinav.sinav_id, int.parse(codeSanner));
                setState(() {
                  qrCodeResult = codeSanner;
                  durum = sonuc;
                });
              },
              child: Text(
                "Tarayıcıyı Aç",
                style:
                TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }
}
