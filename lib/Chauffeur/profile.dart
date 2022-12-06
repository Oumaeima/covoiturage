import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wetrajet/widget/appBar_widget.dart';

import '../controller/auth_controller.dart';

class ProfileChauffeur extends StatefulWidget {
  const ProfileChauffeur({Key? key}) : super(key: key);

  @override
  State<ProfileChauffeur> createState() => _ProfileChauffeurState();
}

class _ProfileChauffeurState extends State<ProfileChauffeur> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    authController.getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
         alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children:   [
              authController.driverModel.value.image == null? CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assets/homme.png'),
              ): CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(authController.driverModel.value.image!),
              ),
              SizedBox(
                height: 20,
              ),
              authController.driverModel.value.name == null? Text(
                  "Labidi Oumaima",
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 20,
                ),
              ): Text(
                authController.driverModel.value.name!,
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 20,
                ),
              ),
              Text(
                "Driver",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Pacifico",
                  fontSize: 15,
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("0", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 10,
                  ),
                  Text("0", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 10,
                  ),
                  Text("0", style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Reviews"),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Teams"),

                  SizedBox(
                    width: 10,
                  ),
                  Text("Recommends"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              Card(
                margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                child: Column(
                  children: [
                    ListTile(
                      trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                      title: Text("Information de base", style: TextStyle(fontSize: 15),),
                      onTap: (){

                        Navigator.pushNamed(context, "info");
                      },
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    ListTile(
                      trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                      title: Text("Permis de conduire", style: TextStyle(fontSize: 15),),
                      onTap: (){
                        Navigator.pushNamed(context, "permisC");
                      },
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    ListTile(
                      trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                      title: Text("Information véhicule", style: TextStyle(fontSize: 15),),
                      onTap: (){
                        Navigator.pushNamed(context, "infoV");
                      },
                    ),
                  ],
                )
              ),
          ],
          ),
        ),
      )
    );
  }
}
