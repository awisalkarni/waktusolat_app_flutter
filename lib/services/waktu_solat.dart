import 'dart:convert';
import 'package:http/http.dart';

class WaktuSolat {
  String zone;
  String year;
  String month;
  String key;
  var pray_list;
  var pray_times;

  WaktuSolat({this.zone, this.year, this.month});

  Future<void> getPrayTimes() async {

    try {

      Response response = await get("http://waktusolatapp.com/api/v1/waktu-solat?key=lamawesome2014&month=$month&year=$year&zone=$zone");
      Map data = jsonDecode(response.body);
      pray_list = data['data']['pray']['pray_list'];
      pray_times = data['data']['pray']['pray_time'];

    }
    catch(e){
      print('caught error:  $e');

    }

  }

}