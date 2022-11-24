import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wetrajet/Chauffeur/InfoBase.dart';
import 'package:wetrajet/Chauffeur/Permis.dart';
import 'package:wetrajet/Chauffeur/infoVehicule.dart';
import 'package:wetrajet/compte.dart';
import 'package:wetrajet/credentials.dart';
import 'package:wetrajet/home.dart';
import 'package:wetrajet/inscription.dart';
import 'package:wetrajet/otp.dart';
import 'package:wetrajet/phone.dart';

import 'controller/auth_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(

    initialRoute: 'home',
    routes: {
      'phone': (context) => MyPhone(),
      'otp': (context) => MyOtp(),
      'credentials': (context) => Credentials(),
      'inscription': (context) => Inscription(),
      'info': (context) => InfoBase(),
      'home': (context) => Home(),
      'compte': (context) => Compte(),
      'permisC': (context) => PermisChauffeur(),
      'infoV': (context) => InfoVehiculeChauffeur(),
    },
  ));
}

