import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

            child: Column(
              children: [
                Stack(

                  children: [
                    Image.asset('lib/assets/road3.png', fit: BoxFit.fill),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: size.height*0.25),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Image.asset('lib/assets/logo2.png', width: 100, height: 100,),
                              SizedBox(
                                height: 45,
                              ),

                              SizedBox(
                                width: 200.0,
                                child: OutlinedButton (
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF4BE3B0)
                                    ),
                                  ),
                                  onPressed: () {
                                    storeDriverInfo();
                                  },
                                  child: const Text('Car', style: TextStyle(
                                      color: Color(0xFF4BE3B0)
                                  ),),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 200.0,
                                child: OutlinedButton (
                                  style: OutlinedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFF4BE3B0)
                                    ),
                                  ),
                                  onPressed: () {
                                    storeCourierInfo();
                                  },
                                  child: const Text('Courier', style: TextStyle(
                                      color: Color(0xFF4BE3B0)
                                  ),),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),

              ],
            )
        ),
      ),
    );
  }

  void storeDriverInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).set({
      'role': "Driver"
    }).then((value){
      Navigator.pushNamed(context, "homePassenger");
    });
  }

  void storeCourierInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).set({
      'role': "Courier"
    }).then((value){
      Navigator.pushNamed(context, "homePassenger");
    });
  }
}
