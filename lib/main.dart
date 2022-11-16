import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wetrajet/credentials.dart';
import 'package:wetrajet/inscription.dart';
import 'package:wetrajet/otp.dart';
import 'package:wetrajet/phone.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    routes: {
      'phone': (context) => MyPhone(),
      'otp': (context) => MyOtp(),
      'credentials': (context) => Credentials(),
      'inscription': (context) => Inscription(),
    },
  ));
}

