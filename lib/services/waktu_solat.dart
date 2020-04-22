import 'dart:convert';
import 'package:http/http.dart';

class WaktuSolat {
  String zone;
  String year;
  String month;
  String origin;
  var pray_list;
  var pray_times;

  WaktuSolat({this.zone, this.year, this.month});

  Future<void> getPrayTimes() async {

    try {

      String local = 'http://10.0.2.2:8080';
      String prod = 'http://waktusolatapp.com';

      Response response = await get("${local}/api/v1/waktu-solat?month=$month&year=$year&zone=$zone");
      Map data = jsonDecode(response.body);
      print(data);
      pray_list = data['data']['pray']['pray_list'];
      pray_times = data['data']['pray']['pray_time'];
      origin = data["data"]["origin"];

    }
    catch(e){
      print('caught error:  $e');

    }

  }

}