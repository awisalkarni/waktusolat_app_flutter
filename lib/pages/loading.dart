import 'package:flutter/material.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/services/waktu_solat.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:waktusolatapp/services/zones.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WaktuSolat instance  = WaktuSolat(zoneCode: "sgr01", month: "04", year: "2020");
    await instance.getPrayTimes();

    Zones zones  = Zones();
    await zones.getZones();

    List zoneList = zones.zones;

    var now = new DateTime.now();

    List prayTimes = instance.prayTimes;

    print(prayTimes);

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
