

class PrayTime {
  String hijri_date;
  String date;
  int imsak;
  int subuh;
  int syuruk;
  int dhuha;
  int zohor;
  int asar;
  int maghrib;
  int isyak;

  PrayTime.fromJson(Map json)
      : hijri_date = json['hijri_date'],
        date = json['date'],
        imsak = json["imsak"],
        subuh = json["subuh"],
        syuruk = json["syuruk"],
        dhuha = json["dhuha"],
        zohor = json["zohor"],
        asar = json["asar"],
        maghrib = json["maghrib"],
        isyak = json["isyak"]
  ;

  Map toJson() {
    return {
      'hijri_date': hijri_date,
      'date': date,
      'imsak': imsak,
      'subuh': subuh,
      'syuruk': syuruk,
      'dhuha': dhuha,
      'zohor': zohor,
      'asar': asar,
      'maghrib': maghrib,
      'isyak': isyak
    };
  }

}