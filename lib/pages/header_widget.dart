import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
    @required this.data,
    @required this.nextActive,
    @required this.difference,
    @required this.hijriDate,
    @required this.normalDate,
  }) : super(key: key);

  final Map data;
  final Map<String, String> nextActive;
  final String difference;
  final String hijriDate;
  final String normalDate;

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
            flex: 3,
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
                              color: Colors.white),
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
                  nextActive.keys.elementAt(0),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                Text(
                  nextActive[nextActive.keys.elementAt(0)],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  hijriDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  normalDate,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  iconSize: 24.0,
                  icon: SvgPicture.asset("assets/menu.svg"),
                  tooltip: 'Open Settings',
                  onPressed: () {},
                ),
                SvgPicture.asset(
                  "assets/pray_icons/subuh.svg",
                  height: 80.0,
                  width: 80.0,
                ),
                SizedBox(height: 41.0),
                Text(
                  difference,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
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
            return Container(
              child: ListTile(
                onTap: (){

                },
                subtitle: Text(
                  zones[index].state,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                title: Text(
                  zones[index].location,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        );
      });
}
