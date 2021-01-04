import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qrcode/models/dbhelper.dart';
import 'package:qrcode/models/oturumModel.dart';
import 'package:qrcode/witgets/myDrawer.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';


class RaporlamaSayfasi extends StatefulWidget {
  RaporlamaSayfasi({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RaporlamaSayfasiState();
}


class _RaporlamaSayfasiState extends State {
  Future<List<Oturum>> _oturum = DBHelper().getAllOturumlar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Sınav Oturum Raporları")),
      drawer: MyDrawer(),

      body: FutureBuilder<List<Oturum>>(

        future: DBHelper().getAllOturumlar(),
        builder: (BuildContext context, AsyncSnapshot<List<Oturum>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Oturum item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBHelper().blockOrUnblockOturum(item);
                  },
                  child: ListTile(
                    title: Text(
                        item.sinav_adi + "=> " + item.ogrenci_id.toString() +
                            " - " + item.ogrenci_adi,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    leading: Text(item.oturum_id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBHelper().blockOrUnblockOturum(item);
                        setState(() {});
                      },
                      value: item.blocked,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings_backup_restore),
        tooltip: "Tüm Oturumları Sil",
        onPressed: () async {
          await DBHelper().deleteAllOturum();
          print("işlem oldu");


          setState(() {});
        },
      ),
    );
  }
}

