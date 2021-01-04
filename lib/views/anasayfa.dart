import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/models/dbhelper.dart';
import 'package:qrcode/models/sinavModel.dart';
import 'package:qrcode/scan.dart';
import 'package:qrcode/witgets/myDrawer.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';


class Anasayfa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Aktif Sınavlarınız Listelenmektedir")),
        drawer: MyDrawer(),

        body: new Builder(
            builder: (BuildContext context) {
              return Column(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: FutureBuilder<List<Sinav>>(


                      future: DBHelper().getUnblockedSinav(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Sinav>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              Sinav item = snapshot.data[index];
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(color: Colors.red),
                                onDismissed: (direction) {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context) => ScanPage(item)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amberAccent,
                                      border: Border.all()),
                                  margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(

                                    title: Text("Sınav Adı : " + item.sinav_adi,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    leading: Text(
                                      "Açıklama : " + item.sinav_aciklama,
                                      textAlign: TextAlign.center,

                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.redAccent,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),),

                                  ),),
                              );
                            },
                          );
                        } else {
                          return Center(child:
                          Text("Aktif Sınav Bulunmamaktadır"),);
                        }
                      },
                    ),
                  ),


                ],
              );
            }
        )
    );
  }
}

