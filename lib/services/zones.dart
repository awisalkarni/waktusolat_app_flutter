import 'dart:convert';
import 'package:http/http.dart';
import 'package:waktusolatapp/model/zone.dart';

class Zones {
  List<Zone> zones;

  Future<void> getZones() async {

    try {

      String local = 'http://10.0.2.2:8080';
      String prod = 'http://waktusolatapp.com';

      Response response = await get("${prod}/api/v1/zones");
//      Map data = jsonDecode(response.body);

      Iterable list = json.decode(response.body)["data"];
      zones = list.map((model) => Zone.fromJson(model)).toList();

    }
    catch(e){
      print('caught error:  $e');

    }

  }


}

