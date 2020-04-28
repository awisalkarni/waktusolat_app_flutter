import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrayTimeWidget extends StatelessWidget {
  const PrayTimeWidget({
    Key key,
    @required this.bgColor,
    @required this.prayKey,
    @required this.time,
    @required this.isActive,
    @required this.isNextActive,
  }) : super(key: key);

  final Color bgColor;
  final String prayKey;
  final String time;
  final bool isActive;
  final bool isNextActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (isActive) ? Color.fromARGB(255, 243, 156, 18) : bgColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 16.0, 15.0),
        child: ListTile(
          onTap: () {},
          leading: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 40,
              maxHeight: 28,
            ),
//            child: Image.asset('assets/pray_icons/${prayKey.toLowerCase()}.svg', fit: BoxFit.cover),
            child: SvgPicture.asset('assets/pray_icons/imsak.svg',
                fit: BoxFit.cover),
          ),
          title: Text(
            prayKey,
            style: TextStyle(
                color: Colors.white, fontSize: 24.0),
          ),
          trailing: Text(
            time,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
