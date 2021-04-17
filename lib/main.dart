
import 'dart:js';

import 'package:enviroCar/screens/bluetooth.dart';
import 'package:enviroCar/screens/home.dart';
import 'package:enviroCar/screens/login.dart';
import 'package:enviroCar/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: "login",
      routes: {
        "login": (context) => Login(),
        "register": (context) => Register(),
        "home": (context) => Home(),
        "bluetooth": (context) => Bluetooth()
      },
      debugShowCheckedModeBanner: false,
    ),
  ); //runApp 
}
