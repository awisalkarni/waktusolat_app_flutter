import 'package:flutter/material.dart';
import 'package:waktusolatapp/pages/choose_location.dart';
import 'package:waktusolatapp/pages/home.dart';
import 'package:waktusolatapp/pages/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));
