import 'dart:convert';

import 'dart:typed_data';
/// ogrenciModel.dart
Ogrenci ogrenciFromJson(String str) {
  final jsonData = json.decode(str);
  return Ogrenci.fromMap(jsonData);
}

String ogrenciToJson(Ogrenci data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Ogrenci {
  int ogrenci_id;
  String ogrenci_adi;
  bool blocked;


  Ogrenci({
    // ignore: non_constant_identifier_names
    this.ogrenci_id,
    this.ogrenci_adi,
    this.blocked,
  });

  // gelen map verisini json'a dönüştürür
  factory Ogrenci.fromMap(Map<String, dynamic> json) => new Ogrenci(
    ogrenci_id: json["ogrenci_id"],
    ogrenci_adi: json["ogrenci_adi"],
    blocked: json["blocked"] == 1,
  );

  // gelen json' verisini Map'e dönüştürür
  Map<String, dynamic> toMap() => {
    "ogrenci_id": ogrenci_id,
    "ogrenci_adi": ogrenci_adi,
    "blocked": blocked,
  };
}