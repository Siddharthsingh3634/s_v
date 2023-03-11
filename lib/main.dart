import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:s_v/add.dart';

import 'package:s_v/itemgrplst.dart';
import 'package:s_v/itemgrplst.dart';
import 'package:s_v/uom.dart';
import 'package:s_v/workrolepage.dart';

import 'checkout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: checkOut(
       
      ),
    );
  }
}

