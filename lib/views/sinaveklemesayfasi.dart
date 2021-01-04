import 'package:flutter/material.dart';
import 'package:qrcode/models/dbhelper.dart';
import 'package:qrcode/models/sinavModel.dart';
import 'package:qrcode/witgets/myDrawer.dart';


class Sinaveklemesayfasi extends StatefulWidget {
  Sinaveklemesayfasi({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SinaveklemeState();
}

class _SinaveklemeState extends State<Sinaveklemesayfasi> {

  @override
  void initState() {
    super.initState();
  }

  String sinav_adi = "";
  String sinav_aciklama = "";
  bool blocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Sınav Ekleme Sayfası")),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          Text("Aşağıdaki Forma Yeni Sınav Bilgilerini Yazınız",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          SizedBox(height: 10),

          TextField(decoration: InputDecoration(labelText: "Sınav Adı",
              border: OutlineInputBorder()
          ), textAlign: TextAlign.center,
            // Her yeni veri girildiğinde çalışır
            onChanged: (veri) {
              sinav_adi = veri;
            },
            // Klavyedeki Gönder(Bitti) tuşuna basınca çalışır
            onSubmitted: (veri) {
              sinav_adi = veri;
            },
          ),
          SizedBox(height: 10),
          //ilaç açıklama
          TextField(decoration: InputDecoration(labelText: "Sinav Açıklaması",
              border: OutlineInputBorder()
          ), textAlign: TextAlign.center,

            onChanged: (veri) {
              sinav_aciklama = veri;
            },

            onSubmitted: (veri) {
              sinav_aciklama = veri;
            },
          ),
          SizedBox(height: 10),


          Center(
              child: RaisedButton(
                  child: Text("Yeni Sınav Ekle"),
                  // Navigator.pop ile bir önceki sayfaya dönücek
                  onPressed: () async {
                    Sinav yeni = Sinav(sinav_adi: sinav_adi,
                        sinav_aciklama: sinav_aciklama,
                        blocked: true);
                    await DBHelper().newSinav(yeni);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("Sınav Ekleme İşlemi"),
                              content: Text("Başarılı"),
                              actions: <Widget>[ FlatButton(
                                child: Text("Kapat"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                              ]
                          );
                        }
                    );
                  }
                //onPressed: () => Navigator.pop(context),
              )),
        ],
      ),
    );
  }


}
