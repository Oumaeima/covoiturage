import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wetrajet/Models/driver.dart';
import 'package:wetrajet/Models/group.dart';


class GroupController extends GetxController{

  String userUid = "";
  var verId = "";
  int? resendTokenId;
  bool phoneAuthCheck = false;
  dynamic credentials;


  var groupModel = GroupModel().obs;


  getGroupInfo(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("groups").doc(uid).snapshots().listen((event) {
      groupModel.value = GroupModel.formJson(event.data()!);
    });
    //print(uid);
  }

}