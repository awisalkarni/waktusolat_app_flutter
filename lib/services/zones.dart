import 'dart:convert';
import 'package:http/http.dart';
import 'package:waktusolatapp/model/zone.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Zones {
  List<Zone> zones;

  Future<void> getZones() async {

    try {

      final prefs = await SharedPreferences.getInstance();

      // read
      final zonePrefs = prefs.getString('zones') ?? null;
      Map data;

      if (zonePrefs == null) {
        String local = 'http://10.0.2.2:8080';
        String prod = 'http://waktusolatapp.com';

        Response response = await get("${prod}/api/v1/zones");
        data = jsonDecode(response.body);
        //save
        prefs.setString('zones', response.body);
      } else {
        data = jsonDecode(zonePrefs);
      }

      Iterable list = data["data"];
      zones = list.map((model) => Zone.fromJson(model)).toList();

    }
    catch(e){
      print('caught error:  $e');

    }

  }


}

