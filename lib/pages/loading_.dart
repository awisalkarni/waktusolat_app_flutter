import 'package:flutter/material.dart';
import 'package:waktusolatapp/services/waktu_solat.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    WaktuSolat instance  = WaktuSolat(zone: "sgr02", month: "04", year: "2020");
    await instance.getPrayTimes();

    var now = new DateTime.now();

    print(now.day);

    List prayList = instance.pray_list != null ? List.from(instance.pray_list) : null;
//    List prayTimeList = instance.pray_times != null ? List.from(instance.pray_times) : null;
    List todayList = instance.pray_times[now.day-1];
    print('unsorted: $todayList');
    todayList.sort();
    print('sorted $todayList');

    Map prayListMap = Map();

    for (int i = 0; i < prayList.length; i++) {
      prayListMap[prayList[i]] = todayList[i];
    }

    print(prayListMap);

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'zone': instance.zone,
      'month': instance.month,
      'year': instance.year,
      'origin': instance.origin,
      'prayListMap': prayListMap
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
