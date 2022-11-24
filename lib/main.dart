import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wetrajet/credentials.dart';
import 'package:wetrajet/inscription.dart';
import 'package:wetrajet/otp.dart';
import 'package:wetrajet/phone.dart';

import 'coursier/delivery.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'coursier',
    routes: {
      'phone': (context) => MyPhone(),
      'otp': (context) => MyOtp(),
      'credentials': (context) => const Credentials(),
      'inscription': (context) => const Inscription(),
      'coursier':(context)=> const Delivery(),

    },
  ));
}

