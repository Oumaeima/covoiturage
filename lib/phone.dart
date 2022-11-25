import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wetrajet/controller/auth_controller.dart';
import 'package:wetrajet/otp.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {

  TextEditingController countryCode = TextEditingController();
  var phoneNumber = "";
  AuthController authController = Get.put(AuthController());


  @override
  void initState() {
    countryCode.text = "+216";
    super.initState();
    authController.decidedRoute();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/login.png', height: 200, width: 200,),
              SizedBox(
                height: 10,
              ),
              Text('Phone verification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),

              Text('We need to register your phone before getting started',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,),

              SizedBox(
                height: 30,
              ),

              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryCode,
                        decoration: InputDecoration(
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("|", style: TextStyle(
                        fontSize: 33, color: Colors.grey
                    ),),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value){
                          phoneNumber=value;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone number"
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:  ElevatedButton(
                  onPressed: () async{
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${countryCode.text+phoneNumber}',
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        MyPhone.verify = verificationId;
                        Navigator.pushNamed(context, "otp");
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );

                  }, child: Text('Send the code'),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4BE3B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    elevation: 10
                  ),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
