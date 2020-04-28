import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/pages/pray_time_tile.dart';
import 'package:waktusolatapp/pages/header_widget.dart';
import 'package:waktusolatapp/model/zone.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  Map data = {};
  PrayTime prayTime;
  Map prayListMap;
  String currentActive;
  String nextActive = "";
  DateTime now;
  String hijriDate;
  String normalDate;
  Timer timer;

  @override
  void initState() {
    super.initState();
  }
  


  @override
  void deactivate() {
    timer.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void reloadData(){
    setState(() {
      List prayTitles = List();
      now = DateTime.now();
      var unixTimestampNow = now.millisecondsSinceEpoch / 1000;

      var activePosition = 0;
      var pos = 0;

      void iterateMapEntry(key, value) {
        if (unixTimestampNow > value) {
          currentActive = key;
          activePosition = pos;
        }
        pos++;
        prayTitles.add(key);
      }

      if (currentActive == null && prayListMap.length > 0) {
        currentActive = prayListMap.keys.elementAt(prayListMap.length-1);
        nextActive = prayListMap.keys.elementAt(0);
      }

      prayListMap.forEach(iterateMapEntry);

      if (currentActive != "Isyak") {
        nextActive = prayTitles[activePosition + 1];
      } else {
        nextActive = prayTitles[0];
      }
    });
  }

  void setTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer){
      if (this.mounted) {
        reloadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    prayTime = data["prayTime"];
    prayListMap = {
//      "Imsak": prayTime.imsak,
      "Subuh": prayTime.subuh,
      "Syuruk": prayTime.syuruk,
      "Dhuha": prayTime.dhuha,
      "Zohor": prayTime.zohor,
      "Asar": prayTime.asar,
      "Maghrib": prayTime.maghrib,
      "Isyak": prayTime.isyak
    };

    hijriDate = prayTime.hijri_date;
    normalDate = prayTime.date;
    setTimer();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 135, 64),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            var itemWidget;
            Color bgColor = index % 2 == 0
                ? Color.fromARGB(255, 64, 135, 64)
                : Color.fromARGB(255, 56, 119, 56);
            if (index == 0) {
              Map<String, String> nextActivePrayTime = {"loading": "00:00"};
              String differenceString = "loading";

              if (prayListMap[nextActive] != null) {
                var timeNext = prayListMap[nextActive];
                DateTime nextActiveTime =
                    DateTime.fromMillisecondsSinceEpoch(timeNext * 1000);
                String time = DateFormat.jm().format(nextActiveTime);
                nextActivePrayTime = {nextActive: time};

                if (nextActiveTime.isBefore(now)) {
                  nextActiveTime = nextActiveTime.add(Duration(days: 1));
                }
                Duration difference = nextActiveTime.difference(now);
                var hours = difference.inHours.abs();
                var mins = difference.inMinutes.remainder(60).abs();
                var secs = difference.inSeconds.remainder(60).abs();
                differenceString = (hours == 0)
                    ? "$mins minit $secs saat lagi"
                    : "$hours jam $mins minit lagi";

                differenceString = (mins == 0 && hours == 0)
                    ? "$secs saat lagi"
                    : differenceString;
              }

              itemWidget = HeaderWidget(
                data: data,
                nextActive: nextActivePrayTime,
                difference: differenceString,
                hijriDate: hijriDate,
                normalDate: normalDate,
                changeZone: (Zone zone) async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString("zone_code", zone.code);
                  Phoenix.rebirth(context);
                }
              );
            } else {
              String prayKey = prayListMap.keys.elementAt(index - 1);
              var date = DateTime.fromMillisecondsSinceEpoch(
                  prayListMap[prayKey] * 1000);
              String time = DateFormat.jm().format(date);
              itemWidget = PrayTimeWidget(
                  bgColor: bgColor,
                  prayKey: prayKey,
                  time: time,
                  isActive: (prayKey == currentActive),
                  isNextActive: (prayKey == nextActive));
            }

            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: itemWidget,
                  ),
                ));
          },
        ),
      ),
    );
  }


}
