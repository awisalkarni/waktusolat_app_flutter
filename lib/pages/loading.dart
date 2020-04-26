import 'package:flutter/material.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/services/waktu_solat.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:waktusolatapp/services/zones.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {

    //try local first
    final prefs = await SharedPreferences.getInstance();

    // read
    final zoneCodePrefs = prefs.getString('zone_code') ?? null;

    final String zoneCode = (zoneCodePrefs != null) ? zoneCodePrefs : "wly01";

    var now = new DateTime.now();
    final String month = now.month.toString();
    final String year = now.year.toString();

    WaktuSolat instance  = WaktuSolat(zoneCode: zoneCode, month: month, year: year);
    await instance.getPrayTimes();

    Zones zones  = Zones();
    await zones.getZones();

    List zoneList = zones.zones;



    List prayTimes = instance.prayTimes;
    PrayTime prayTime = prayTimes[now.day - 1];

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'zone': instance.zone,
      'month': instance.month,
      'year': instance.year,
      'origin': instance.origin,
      'prayTime': prayTime,
      'zones': zoneList
    });


  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();

  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Color.fromARGB(255, 64, 135, 64),
        body: Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 60.0,
          ),
        )
    );
  }


}
