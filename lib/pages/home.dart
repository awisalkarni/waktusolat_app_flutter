import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    Map prayListMap = data["prayListMap"];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 64, 135, 64),
      body: ListView.builder(
        itemCount: prayListMap.length+1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return HeaderWidget(data: data);
          }
          index = index-1;
          String prayKey = prayListMap.keys.elementAt(index);
          var date = new DateTime.fromMillisecondsSinceEpoch(prayListMap[prayKey] * 1000);
          String time = DateFormat.jm().format(date);
          Color bgColor = index%2 == 0 ? Color.fromARGB(255, 64, 135, 64) : Color.fromARGB(255, 56, 119, 56);

          return PrayTimeWidget(bgColor: bgColor, prayKey: prayKey, time: time);
        },
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
        padding: EdgeInsets.fromLTRB(16.0, 21.0, 16.0, 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    data["zone"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),
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
                  "26 Syaaban 1441",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  "20 April 2020",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                FlatButton(
                 child: Image(
                   image: AssetImage('assets/setting.png'),
                 ),
                )

              ],
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
      child: ListTile(
        onTap: () {

        },
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 40,
            maxHeight: 28,
          ),
          child: Image.asset('assets/${prayKey.toLowerCase()}.png', fit: BoxFit.cover),
        ),
        title: Text(
          prayKey,
          style: TextStyle(
              color: Colors.white,
            fontSize: 20.0
          ),
        ),
        trailing: Text(
            time,
          style: TextStyle(
              color: Colors.white,
            fontSize: 20.0
          ),
        ),
      ),
    );
  }
}


