import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waktusolatapp/model/pray_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  Map data = {};


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    PrayTime prayTime = data["prayTime"];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 135, 64),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {

            var itemWidget;
            Color bgColor = index%2 == 0 ? Color.fromARGB(255, 64, 135, 64) : Color.fromARGB(255, 56, 119, 56);
            if (index == 0) {
              itemWidget = HeaderWidget(data: data);
            } else {

              Map prayListMap = {
                "Imsak": prayTime.imsak,
                "Subuh": prayTime.subuh,
                "Dhuha": prayTime.dhuha,
                "Syuruk": prayTime.syuruk,
                "Zohor": prayTime.zohor,
                "Asar": prayTime.asar,
                "Maghrib": prayTime.maghrib,
                "Isyak": prayTime.isyak
              };

              String prayKey = prayListMap.keys.elementAt(index-1);
              var date = new DateTime.fromMillisecondsSinceEpoch(prayListMap[prayKey] * 1000);
              String time = DateFormat.jm().format(date);
              itemWidget = PrayTimeWidget(bgColor: bgColor, prayKey: prayKey, time: time);
            }

            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: itemWidget,
                    ),
                )
            );
          },
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                              data['zone'].location,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SvgPicture.asset("assets/chevron.svg")
                      ],
                    ),
                    onPressed: () {
                      _settingModalBottomSheet(context, data);
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Zohor",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,

                    ),
                  ),
                  Text(
                    "1:00 PM",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    data["prayTime"].hijri_date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    data["prayTime"].date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    iconSize: 24.0,
                    icon: SvgPicture.asset("assets/menu.svg"),
                    tooltip: 'Open Settings',
                    onPressed: () {

                    },
                  ),
                  SvgPicture.asset("assets/pray_icons/subuh.svg", height: 80.0, width: 80.0,),
                  SizedBox(height: 41.0),
                  Text(
                    "20 April 2020",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )

    );
  }
}

class PrayTimeWidget extends StatelessWidget {
  const PrayTimeWidget({
    Key key,
    @required this.bgColor,
    @required this.prayKey,
    @required this.time,
  }) : super(key: key);

  final Color bgColor;
  final String prayKey;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 20.0),
        child: ListTile(
          onTap: () {

          },
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 40,
              maxHeight: 28,
            ),
//            child: Image.asset('assets/pray_icons/${prayKey.toLowerCase()}.svg', fit: BoxFit.cover),
            child: SvgPicture.asset('assets/pray_icons/imsak.svg', fit: BoxFit.cover),
          ),
          title: Text(
            prayKey,
            style: TextStyle(
                color: Colors.white,
              fontSize: 20.0,
              fontFamily: 'Inter'
            ),
          ),
          trailing: Text(
              time,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter'
            ),
          ),
        ),
      ),
    );
  }
}

void _settingModalBottomSheet(context, data) {
  List zones = data["zones"];
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (BuildContext bc) {
        return ListView.builder(
          itemCount: zones.length,
          itemBuilder: (context, index) {
            return ListTile(
              subtitle: Text(
                zones[index].state,
                style: TextStyle(
                    color: Colors.white
                ),),
              title: Text(
                zones[index].location,
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            );
          },
        );
      }
  );
}


