import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:waktusolatapp/model/pray_time.dart';
import 'package:waktusolatapp/model/zone.dart';
import 'package:waktusolatapp/services/waktu_solat.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:waktusolatapp/services/zones.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();

  void initLocalPushNotification() async
  {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await notifications.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  void scheduleLocalNotification(List prayTimes, Zone zone) async
  {
    await notifications.cancelAll();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'waktusolatapp', 'prayer_time_notication', 'Prayer time notification',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    for (PrayTime prayTime in prayTimes) {



      Map prayListMap = {
//      "Imsak": prayTime.imsak,
        "Subuh": prayTime.subuh,
        "Syuruk": prayTime.syuruk,
        "Dhuha": prayTime.dhuha,
        "Zohor": prayTime.zohor,
        "Asar": prayTime.asar,
        "Maghrib": prayTime.maghrib,
        "Isyak": prayTime.isyak
      };

      for (int i = 0; i<prayListMap.length; i++) {
        var prayTimeTimeStamp = prayListMap.values.elementAt(i);
        var now = DateTime.now();
        var unixTimestampNow = now.millisecondsSinceEpoch / 1000;

        if (prayTimeTimeStamp >= unixTimestampNow) {
          DateTime prayTimeSchedule = DateTime.fromMillisecondsSinceEpoch(prayListMap.values.elementAt(i) * 1000);

          String prayTimeTitle = prayListMap.keys.elementAt(i);
          print('waktu: $prayTimeTitle, time: $prayTimeSchedule');

          await notifications.schedule(
              0,
              'Waktu $prayTimeTitle',
              'Telah masuk waktu $prayTimeTitle bagi ${zone.location}',
              prayTimeSchedule,
              platformChannelSpecifics
          );
        }
      }
    }
  }

  void scheduleTest() async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
    print('schedule: $scheduledNotificationDateTime');
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('your other channel id',
        'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifications.schedule(
        0,
        'scheduled title',
        'scheduled body',
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }


  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {
  }

  Future selectNotification(String payload) {

    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

  }

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
    
    //download for next month
    DateTime nextMonth = Jiffy().add(months: 1);
    WaktuSolat(zoneCode: zoneCode, month: nextMonth.month.toString(), year: nextMonth.year.toString());

    //remove last month
    DateTime lastMonth = Jiffy().subtract(months: 1);
    String lastMonthKey = '${zoneCode}_${lastMonth.month.toString()}_${lastMonth.year.toString()}';
    prefs.remove(lastMonthKey);
    
    Zones zones  = Zones();
    await zones.getZones();

    List zoneList = zones.zones;
    List prayTimes = instance.prayTimes;
    PrayTime prayTime = prayTimes[now.day - 1];

    scheduleLocalNotification(prayTimes, instance.zone);

//    scheduleTest();
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
    initLocalPushNotification();
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
