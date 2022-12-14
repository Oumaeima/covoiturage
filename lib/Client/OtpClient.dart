import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:wetrajet/phone.dart';

import '../controller/auth_controller.dart';


class OtpClient extends StatefulWidget {
  const OtpClient({Key? key}) : super(key: key);

  @override
  State<OtpClient> createState() => _OtpClientState();
}

class _OtpClientState extends State<OtpClient> {

  //AuthController authController = Get.find<AuthController>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthController authController = Get.put(AuthController());


  @override
  void initState() {
    super.initState();
    authController.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
          onPressed: () { Navigator.pop(context); },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/login.png', height: 150, width: 150,),
              SizedBox(
                height: 10,
              ),
              Text('Phone verification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),

              Text('Enter your OTP code here',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,),

              SizedBox(
                height: 30,
              ),

              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value){
                  code = value;
                },

              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:  ElevatedButton(
                  onPressed: () async {
                   try{
                     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);
                     // Sign the user in (or link) with the credential
                     await auth.signInWithCredential(credential);
                     Navigator.pushNamedAndRemoveUntil(context, "homePassenger", (route) => false);
                   }catch(e){
                      print("wrong otp");
                   }
                  },
                  child: Text('Verifiy phone number'),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4BE3B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),),
              ),

              Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, "phone", (route) => false);
                  }, child: Text('Edit Phone Number?', style: TextStyle(color: Colors.black),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
