import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wetrajet/Models/driver.dart';
import 'package:wetrajet/credentials.dart';
import 'package:wetrajet/home.dart';

class AuthController extends GetxController{

  String userUid = "";
  var verId = "";
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;

  phoneAuth(String phone) async{
    try{
        credentials = null;
        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phone,
            timeout: const Duration(seconds: 60),
            verificationCompleted: (PhoneAuthCredential credential) async{
              print("completed");
              credentials = credential;
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            forceResendingToken: resendTokenId,
            verificationFailed: (FirebaseAuthException e){
              print("Failed");
              if(e.code == 'invalid-phone-number'){
                debugPrint('the provided phone number is not valid.');
              }
            },
            codeSent: (String verificationId, int? resendToken) async {
              verId = verificationId;
              resendTokenId = resendToken;
            },
            codeAutoRetrievalTimeout: (String verificationId){}
        );
    }catch(e){
      print("error occured $e");
    }
  }

  decidedRoute(){
    // check if user is logged in?
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      // check user profile exist?
      FirebaseFirestore.instance.collection('driver').doc(user.uid).get()
          .then((value){
            if(value.exists){
              Future<dynamic>?  goToPath(){
                Get.to(() => const Home());
                return null;
              }
            }else{
              Future<dynamic>?  goToPath(){
                Get.to(() => const Credentials());
                return null;
              }
            }
      });
    }
  }

  var driverModel = DriverModel().obs;

  getUserInfo(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).snapshots().listen((event) {
      driverModel.value = DriverModel.formJson(event.data()!);
    });
    print(uid);
  }
}