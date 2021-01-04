import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qrcode/models/dbhelper.dart';
import 'package:qrcode/models/ogrenciModel.dart';
import 'package:qrcode/witgets/myDrawer.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class Ogrencilisteleme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OgrencilistelemeState();
}

class _OgrencilistelemeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Öğrenci Listesi")),
      drawer: MyDrawer(),
      body: FutureBuilder<List<Ogrenci>>(
        future: DBHelper().getAllOgrenciler(),
        builder: (BuildContext context, AsyncSnapshot<List<Ogrenci>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Ogrenci item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBHelper().deleteOgrenci(item.ogrenci_id);
                  },
                  child: ListTile(
                    title: Text(item.ogrenci_adi,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: RichText(
                      text: TextSpan(
                        text: item.ogrenci_adi,
                      ),
                    ),
                    leading: Text(item.ogrenci_id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBHelper().blockOrUnblockOgrenci(item);
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
        tooltip: "Tüm Öğrencileri Sil",
        onPressed: () async {
          await DBHelper().deleteAllOgrenci();
          print("işlem oldu");
          setState(() {});
        },
      ),
    );
  }
}
