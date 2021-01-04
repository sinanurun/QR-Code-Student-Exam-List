import 'package:flutter/material.dart';
import 'package:qrcode/models/dbhelper.dart';
import 'package:qrcode/models/ogrenciModel.dart';
import 'package:qrcode/witgets/myDrawer.dart';

class Ogrencieklemesayfasi extends StatefulWidget {
  Ogrencieklemesayfasi({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OgrencieklemeState();
}

class _OgrencieklemeState extends State<Ogrencieklemesayfasi> {
  @override
  void initState() {
    super.initState();
  }

  int ogrenci_id = 0;
  String ogrenci_adi = "";
  bool blocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Öğrenci Ekleme Sayfası")),
      drawer: MyDrawer(),
//      resizeToAvoidBottomPadding: false,
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text("Aşağıdaki Forma Yeni Öğrenci Bilgilerini Yazınız",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          SizedBox(height: 10),
          //ilaç adı
          TextField(
            decoration: InputDecoration(
                labelText: "Öğrenci İd - No", border: OutlineInputBorder()),
            textAlign: TextAlign.center,
            // Her yeni veri girildiğinde çalışır
            onChanged: (veri) {
              ogrenci_id = int.parse(veri);
            },
            // Klavyedeki Gönder(Bitti) tuşuna basınca çalışır
            onSubmitted: (veri) {
              ogrenci_id = int.parse(veri);
            },
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                labelText: "Öğrenci Adı - Soyadı",
                border: OutlineInputBorder()),
            textAlign: TextAlign.center,
            // Her yeni veri girildiğinde çalışır
            onChanged: (veri) {
              ogrenci_adi = veri;
            },
            // Klavyedeki Gönder(Bitti) tuşuna basınca çalışır
            onSubmitted: (veri) {
              ogrenci_adi = veri;
            },
          ),
          SizedBox(height: 10),

          Center(
              child: RaisedButton(
                  child: Text("Yeni Öğrenci Ekle"),
                  // Navigator.pop ile bir önceki sayfaya dönücek
                  onPressed: () async {
                    Ogrenci yeni = Ogrenci(
                        ogrenci_id: ogrenci_id,
                        ogrenci_adi: ogrenci_adi,
                        blocked: true);
                    await DBHelper().newOgrenci(yeni);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("Öğrenci Ekleme İşlemi"),
                              content: Text("Başarılı"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Kapat"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ]);
                        });
                  }
                  //onPressed: () => Navigator.pop(context),
                  )),
        ],
      ),
    );
  }
}
