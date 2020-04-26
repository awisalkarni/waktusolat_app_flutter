import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:waktusolatapp/pages/choose_location.dart';
import 'package:waktusolatapp/pages/home.dart';
import 'package:waktusolatapp/pages/loading.dart';

void main() => runApp(Phoenix(
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
          '/location': (context) => ChooseLocation(),
        },
      ),
    ));
