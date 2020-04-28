import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:waktusolatapp/pages/home.dart';
import 'package:waktusolatapp/pages/loading.dart';


void main() => runApp(Phoenix(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
        },
      ),
    )
);
