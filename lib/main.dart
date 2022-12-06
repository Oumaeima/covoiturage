import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wetrajet/Chauffeur/InfoBase.dart';
import 'package:wetrajet/Chauffeur/Permis.dart';
import 'package:wetrajet/Chauffeur/add-group.dart';
import 'package:wetrajet/Chauffeur/infoVehicule.dart';
import 'package:wetrajet/Chauffeur/profile.dart';
import 'package:wetrajet/Client/GroupClient.dart';
import 'package:wetrajet/Client/OtpClient.dart';
import 'package:wetrajet/Client/homeClient.dart';
import 'package:wetrajet/Client/loginClient.dart';
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
    initialRoute: "home",
    routes: {
      'phone': (context) => MyPhone(),
      'otp': (context) => MyOtp(),
      'credentials': (context) => Credentials(),
      'inscription': (context) => Inscription(),
      'info': (context) => InfoBase(),
      'home': (context) => Home(),
      'homePassenger': (context) => HomePassenger(),
      'loginPassenger': (context) => LoginClient(),
      'otpPassenger': (context) => OtpClient(),
      'groupsClient': (context) => Groups(),
      'compte': (context) => Compte(),
      'permisC': (context) => PermisChauffeur(),
      'infoV': (context) => InfoVehiculeChauffeur(),
      'profileC': (context) => ProfileChauffeur(),
      'add-group': (context) => AddGroup(),
    },
  ));
}

