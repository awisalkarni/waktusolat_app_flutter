import 'dart:convert';
import 'package:http/http.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/model/zone.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WaktuSolat {
  String zoneCode;
  String year;
  String month;
  String origin;
  List<PrayTime> prayTimes;
  Zone zone;

  WaktuSolat({this.zoneCode, this.year, this.month});

  Future<void> getPrayTimes() async {

    try {
      //try local first
      final prefs = await SharedPreferences.getInstance();

      // read
      final prayerTimePrefs = prefs.getString('${zoneCode}_${month}_${year}') ?? null;
      Map data;

      if (prayerTimePrefs == null) {
        String local = 'http://10.0.2.2:8080';
        String prod = 'http://waktusolatapp.com';

        Response response = await get("${prod}/api/v2/waktu-solat?month=$month&year=$year&zone=$zoneCode");
        data = jsonDecode(response.body);

        //save
        prefs.setString('${zoneCode}_${month}_${year}', response.body);
      } else {
        data = jsonDecode(prayerTimePrefs);
      }

      Iterable prayTimeList = data["data"]["pray_times"];
      Map zoneMap = data["data"]["zone"];
      zone = Zone.fromJson(zoneMap);
      prayTimes = prayTimeList.map((model) => PrayTime.fromJson(model)).toList();
    }
    catch(e){
      print('caught error:  $e');

    }

  }

}