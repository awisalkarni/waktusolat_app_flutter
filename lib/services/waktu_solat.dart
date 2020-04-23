import 'dart:convert';
import 'package:http/http.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/model/zone.dart';

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
      String local = 'http://10.0.2.2:8080';
      String prod = 'http://waktusolatapp.com';

      Response response = await get("${prod}/api/v2/waktu-solat?month=$month&year=$year&zone=$zoneCode");
      Map data = jsonDecode(response.body);

//      print(data);

      Iterable prayTimeList = data["data"]["pray_times"];
      Map zoneMap = data["data"]["zone"];
      zone = Zone.fromJson(zoneMap);
//      print(zone);
      prayTimes = prayTimeList.map((model) => PrayTime.fromJson(model)).toList();
    }
    catch(e){
      print('caught error:  $e');

    }

  }

}