import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/pages/pray_time_tile.dart';
import 'package:waktusolatapp/pages/header_widget.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    prayTime = data["prayTime"];

    hijriDate = prayTime.hijri_date;

    normalDate = prayTime.date;

    prayListMap = {
      "Imsak": prayTime.imsak,
      "Subuh": prayTime.subuh,
      "Syuruk": prayTime.syuruk,
      "Dhuha": prayTime.dhuha,
      "Zohor": prayTime.zohor,
      "Asar": prayTime.asar,
      "Maghrib": prayTime.maghrib,
      "Isyak": prayTime.isyak
    };

    List prayTitles = List();

    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
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

              prayListMap.forEach(iterateMapEntry);

              if (currentActive != "Isyak") {
                nextActive = prayTitles[activePosition + 1];
              } else {
                nextActive = prayTitles[0];
              }
            }));

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 135, 64),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 9,
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
                Duration difference = nextActiveTime.difference(now);
                differenceString = (difference.inHours == 0)
                    ? "${difference.inMinutes.remainder(60)} minit ${difference.inSeconds.remainder(60)} saat lagi"
                    : "${difference.inHours} jam ${difference.inMinutes.remainder(60)} minit lagi";
              }

              itemWidget = HeaderWidget(
                data: data,
                nextActive: nextActivePrayTime,
                difference: differenceString,
                hijriDate: hijriDate,
                normalDate: normalDate,
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
