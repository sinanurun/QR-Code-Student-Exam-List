import 'dart:convert';
/// sinavModel.dart
Sinav sinavFromJson(String str) {
  final jsonData = json.decode(str);
  return Sinav.fromMap(jsonData);
}

String sinavToJson(Sinav data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Sinav {
  int sinav_id;
  String sinav_adi;
  String sinav_aciklama;
  bool blocked;

  Sinav({
    // ignore: non_constant_identifier_names
    this.sinav_id,
    this.sinav_adi,
    this.sinav_aciklama,
    this.blocked,
  });

  factory Sinav.fromMap(Map<String, dynamic> json) => new Sinav(
    sinav_id: json["sinav_id"],
    sinav_adi: json["sinav_adi"],
    sinav_aciklama: json["sinav_aciklama"],
    blocked: json["blocked"] == 1,
  );

  Map<String, dynamic> toMap() => {
    "sinav_id": sinav_id,
    "sinav_adi": sinav_adi,
    "sinav_aciklama": sinav_aciklama,
    "blocked": blocked,
  };
}