import 'dart:convert';

/// oturumModel.dart
Oturum oturumFromJson(String str) {
  final jsonData = json.decode(str);
  return Oturum.fromMap(jsonData);
}

String oturumToJson(Oturum data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Oturum {
  int oturum_id;
  int sinav_id;
  String sinav_adi;
  int ogrenci_id;
  String ogrenci_adi;
  bool blocked;

  Oturum({
    // ignore: non_constant_identifier_names
    this.oturum_id,
    this.sinav_id,
    this.sinav_adi,
    this.ogrenci_id,
    this.ogrenci_adi,
    this.blocked,
  });

  // gelen map verisini json'a dönüştürür
  factory Oturum.fromMap(Map<String, dynamic> json) => new Oturum(
        oturum_id: json["oturum_id"],
        sinav_id: json["sinav_id"],
        sinav_adi: json["sinav_adi"],
        ogrenci_id: json["ogrenci_id"],
        ogrenci_adi: json["ogrenci_adi"],
        blocked: json["blocked"] == 1,
      );

  // gelen json' verisini Map'e dönüştürür
  Map<String, dynamic> toMap() => {
        "oturum_id": oturum_id,
        "sinav_id": sinav_id,
        "sinav_adi": sinav_adi,
        "ogrenci_id": ogrenci_id,
        "ogrenci_adi": ogrenci_adi,
        "blocked": blocked,
      };
}
