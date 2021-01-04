import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../models/ogrenciModel.dart';
import '../models/sinavModel.dart';
import '../models/oturumModel.dart';

import 'package:intl/intl.dart';


class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    const ogrenciSQL = "CREATE TABLE Ogrenci ("
        "ogrenci_id INTEGER PRIMARY KEY,"
        "ogrenci_adi TEXT,"
        "blocked BIT"
        ")";
    const sinavSQL = "CREATE TABLE Sinav ("
        "sinav_id INTEGER PRIMARY KEY,"
        "sinav_adi TEXT,"
        "sinav_aciklama TEXT,"
        "blocked BIT"
        ")";
    const oturumSQL = "CREATE TABLE Oturum ("
        "oturum_id INTEGER PRIMARY KEY,"
        "sinav_id INTEGER,"
        "sinav_adi TEXT,"
        "ogrenci_id INTEGER,"
        "ogrenci_adi TEXT,"
        "blocked BIT,"
        "UNIQUE(sinav_id,ogrenci_id),FOREIGN KEY(sinav_id) REFERENCES Sinav(sinav_id)"
        ")";
    return openDatabase(join(dbPath, "mobil_yoklama_uygulamasi.db"),
      onCreate: (db, version) async {
        await db.execute(ogrenciSQL);
        db.execute(sinavSQL);
        db.execute(oturumSQL);
      },
      version: 1,
    );
  }

  newOgrenci(Ogrenci newOgrenci) async {
    final db = await database();
    var sonuc = await db.insert("Ogrenci", newOgrenci.toMap());
    return sonuc;
  }

  Future<List<Ogrenci>> getAllOgrenciler() async {
    final db = await database();
    var sonuc = await db.query("Ogrenci");
    List<Ogrenci> list = sonuc.isNotEmpty ? sonuc.map((c) => Ogrenci.fromMap(c))
        .toList() : [];
    return list;
  }

  Future<List<Ogrenci>> getBlockedOgrenci() async {
    final db = await database();
    var sonuc = await db.query(
        "Ogrenci", where: "blocked = ? ", whereArgs: [1]);
    List<Ogrenci> list = sonuc.isNotEmpty ? sonuc.map((c) => Ogrenci.fromMap(c))
        .toList() : [];
    return list;
  }

  updateOgrenci(Ogrenci newOgrenci) async {
    final db = await database();
    var sonuc = await db.update(
        "Ogrenci", newOgrenci.toMap(), where: "ogrenci_id = ?",
        whereArgs: [newOgrenci.ogrenci_id]);
    return sonuc;
  }

  blockOrUnblockOgrenci(Ogrenci ogrenci) async {
    final db = await database();
    Ogrenci blocked = Ogrenci(ogrenci_id: ogrenci.ogrenci_id,
        ogrenci_adi: ogrenci.ogrenci_adi, blocked: !ogrenci.blocked);
    var sonuc = await db.update(
        "Ogrenci", blocked.toMap(), where: "ogrenci_id = ?",
        whereArgs: [ogrenci.ogrenci_id]);
    return sonuc;
  }

  deleteOgrenci(int ogrenci_id) async {
    final db = await database();
    db.delete("Ogrenci", where: "ogrenci_id = ?", whereArgs: [ogrenci_id]);
    db.delete("Oturum", where: "ogrenci_id = ?", whereArgs: [ogrenci_id]);
  }

  deleteAllOgrenci() async {
    final db = await database();
    db.rawDelete("Delete from Ogrenci");
    db.rawDelete("Delete from Oturum");
  }

  newSinav(Sinav newSinav) async {
    final db = await database();
    var sonuc = await db.insert("Sinav", newSinav.toMap());
    await oturumEkle(sonuc);
    return sonuc;
  }

  Future<List<Sinav>> getAllSinavlar() async {
    final db = await database();
    var sonuc = await db.query("Sinav");
    List<Sinav> list = sonuc.isNotEmpty ? sonuc.map((c) => Sinav.fromMap(c))
        .toList() : [];
    return list;
  }

  Future<List<Sinav>> getBlockedSinav() async {
    final db = await database();
    var sonuc = await db.query("Sinav", where: "blocked = ? ", whereArgs: [0]);
    List<Sinav> list = sonuc.isNotEmpty ? sonuc.map((c) => Sinav.fromMap(c))
        .toList() : [];
    return list;
  }

  Future<List<Sinav>> getUnblockedSinav() async {
    final db = await database();
    var sonuc = await db.query("Sinav", where: "blocked = ? ", whereArgs: [1]);
    List<Sinav> list = sonuc.isNotEmpty ? sonuc.map((c) => Sinav.fromMap(c))
        .toList() : [];
    return list;
  }

  updateSinav(Sinav newSinav) async {
    final db = await database();
    var sonuc = await db.update(
        "Sinav", newSinav.toMap(), where: "sinav_id = ?",
        whereArgs: [newSinav.sinav_id]);
    return sonuc;
  }

  blockOrUnblockSinav(Sinav sinav) async {
    final db = await database();
    Sinav blocked = Sinav(sinav_id: sinav.sinav_id, sinav_adi: sinav.sinav_adi,
        sinav_aciklama: sinav.sinav_aciklama, blocked: !sinav.blocked);
    var sonuc = await db.update("Sinav", blocked.toMap(), where: "sinav_id = ?",
        whereArgs: [sinav.sinav_id]);
    return sonuc;
  }

  deleteSinav(int sinav_id) async {
    final db = await database();
    await db.delete("Sinav", where: "sinav_id = ?", whereArgs: [sinav_id]);
    await db.delete("Oturum", where: "sinav_id = ?", whereArgs: [sinav_id]);
  }

  deleteAllSinav() async {
    final db = await database();
    db.rawDelete("Delete from Sinav");
    db.rawDelete("Delete from Oturum");
  }

  oturumEkle(int sinav_id) async {
    final db = await database();
    var ogrencilistesi = await getAllOgrenciler();
    var ysinav = await db.query(
        "Sinav", where: "sinav_id = ?", whereArgs: [sinav_id]);
    Sinav sinav = Sinav.fromMap(ysinav.first);
    for (var ogrenci in ogrencilistesi) {
      Oturum oturum = Oturum(sinav_id: sinav.sinav_id,
          sinav_adi: sinav.sinav_adi,
          ogrenci_id: ogrenci.ogrenci_id,
          ogrenci_adi: ogrenci.ogrenci_adi,
          blocked: false);
      try {
        await newKullanim(oturum);
      }
      catch (e) {
        print('Hatalı işlem');
      }
    }
  }

  newKullanim(Oturum newOturum) async {
    final db = await database();
    var sonuc = await db.insert("Oturum", newOturum.toMap());
    return sonuc;
  }

  Future<List<Oturum>> getAllOturumlar() async {
    final db = await database();
    var sonuc = await db.query("Oturum");
    List<Oturum> list = sonuc.isNotEmpty ? sonuc.map((c) => Oturum.fromMap(c))
        .toList() : [];
    return list;
  }

  getSinavOturum(int sinav_id) async {
    final db = await database();
    var sonuc = await db.query(
        "Oturum", where: "sinav_id = ?", whereArgs: [sinav_id]);
    List<Oturum> list = sonuc.isNotEmpty ? sonuc.map((c) => Oturum.fromMap(c))
        .toList() : [];
    return list;
  }

  updateOturum(Oturum newOturum) async {
    final db = await database();
    var sonuc = await db.update(
        "Oturum", newOturum.toMap(), where: "oturum_id = ?",
        whereArgs: [newOturum.oturum_id]);
    return sonuc;
  }

  blockOrUnblockOturum(Oturum oturum) async {
    final db = await database();
    Oturum blocked = Oturum(oturum_id: oturum.oturum_id,
        sinav_id: oturum.sinav_id,
        sinav_adi: oturum.sinav_adi,
        ogrenci_id: oturum.ogrenci_id,
        ogrenci_adi: oturum.ogrenci_adi,
        blocked: !oturum.blocked);
    var sonuc = await db.update(
        "Oturum", blocked.toMap(), where: "oturum_id = ?",
        whereArgs: [oturum.oturum_id]);
    return sonuc;
  }

  oturumKontrol(int sinav_id, int ogrenci_id) async {
    final db = await database();
    var sonuc = await db.query(
        "Oturum", where: "(sinav_id = ? and ogrenci_id = ?)",
        whereArgs: [sinav_id, ogrenci_id]);
    print(sonuc);
    if (sonuc.isEmpty) {
      print("deneme");
      return "Öğrenci Sınavda Tanımlı Değil";
    }
    else {
      Oturum oturum = Oturum.fromMap(sonuc.first);
      oturum.blocked = true;
      var sonuc2 = await db.update(
          "Oturum", oturum.toMap(), where: "oturum_id = ?",
          whereArgs: [oturum.oturum_id]);
      return "Öğrenci Sınava Eklendi";
    }
  }

  deleteAllOturum() async {
    final db = await database();
    db.rawDelete("Delete from Oturum");
  }

}