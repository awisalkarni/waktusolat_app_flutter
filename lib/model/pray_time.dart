

import 'package:intl/intl.dart';

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

  PrayTime({
    this.hijri_date,
    this.date,
    this.imsak,
    this.subuh,
    this.syuruk,
    this.dhuha,
    this.zohor,
    this.asar,
    this.maghrib,
    this.isyak
}){

  }



  factory PrayTime.fromJson(Map json) {

    var islamicMonths = [
      "Muharram",
      "Safar",
      "Rabiulawal",
      "Rabiulakhir",
      "Jumadilawal",
      "Jamadilakhir",
      "Rejab",
      "Syaaban",
      "Ramadan",
      "Syawal",
      "Zulkaedah",
      "Zulhijjah",
    ];

    var hijriSplit = json['hijri_date'].split('-');
    var day = hijriSplit[2];
    var month = islamicMonths[int.parse(hijriSplit[1])-1];
    var year = hijriSplit[0];

    final hijriDate = '$day $month $year';

    final date = DateFormat("d MMM yyyy").format(DateFormat("yyyy-M-dd").parse(json['date']));

    return PrayTime(
        hijri_date: hijriDate,
        date: date,
        imsak: json["imsak"],
        subuh: json["subuh"],
        syuruk: json["syuruk"],
        dhuha: json["dhuha"],
        zohor: json["zohor"],
        asar: json["asar"],
        maghrib: json["maghrib"],
        isyak: json["isyak"]
    );
  }

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