import 'dart:convert';
import 'package:http/http.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/model/zone.dart';

class WaktuSolat {
  String zone;
  String year;
  String month;
  String origin;
  List<PrayTime> prayTimes;
  List<Zone> zones;

  WaktuSolat({this.zone, this.year, this.month});

  Future<void> getPrayTimes() async {

    try {

      String local = 'http://10.0.2.2:8080';
      String prod = 'http://waktusolatapp.com';

      Response response = await get("${local}/api/v2/waktu-solat?month=$month&year=$year&zone=$zone");
      Map data = jsonDecode(response.body);

      prayTimes.

    }
    catch(e){
      print('caught error:  $e');

    }

  }

}