import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/auth_controller.dart';

class InfoVehiculeChauffeur extends StatefulWidget {
  const InfoVehiculeChauffeur({Key? key}) : super(key: key);

  @override
  State<InfoVehiculeChauffeur> createState() => _InfoVehiculeChauffeurState();
}

class _InfoVehiculeChauffeurState extends State<InfoVehiculeChauffeur> {

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  TextEditingController plaqueController = TextEditingController();
  TextEditingController marqueController = TextEditingController();

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if(image != null){
      selectedImage = File(image.path);
      setState((){

      });
    }
  }

  uploadImage(File image) async{
    String imageUrl = "";
    String fileName = p.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('users/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value){
      imageUrl = value;
      print("Download url: $value");
    });
    return imageUrl;
  }

  storeUserInfo() async{
    String photo = await uploadImage(selectedImage!);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).update({
      'photo-voiture': photo,
      'plaque-immatriculation' : plaqueController.text,
      'marque-voiture': marqueController.text,
    }).then((value){
      plaqueController.clear();
      marqueController.clear();
      isLoading = false;
      Navigator.pushNamed(context, "home");
    });
  }

  updateUserInfo(File? image, String plaque, String marque,{String url = ''}) async{
    String new_url = url;
    if(image != null){
      new_url = await uploadImage(image);
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).update({
      'photo-voiture': new_url,
      'plaque-immatriculation' : plaqueController.text,
      'marque-voiture': marqueController.text,
    }).then((value){
      plaqueController.clear();
      marqueController.clear();
      isLoading = false;
      Navigator.pushNamed(context, "profileC");
    });
  }

  AuthController authController = Get.put(AuthController());

  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    authController.getUserInfo();
    plaqueController.text = authController.driverModel.value.plaqueImmatriculation??"";
    marqueController.text = authController.driverModel.value.marqueVoiture??"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Information Véhicule"),
          backgroundColor: Colors.black.withOpacity(0.5),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,),
            onPressed: () { Navigator.pop(context); },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 10,
                          ),
                          const Text("Photo de Véhicule"),
                          selectedImage == null? authController.driverModel.value.marqueVoiture == null?
                          Image.asset('lib/assets/car.png', width: 200, height: 200,)
                          : Image.network(authController.driverModel.value.photoVoiture!, width: 200, height: 200,)
                          : Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(selectedImage!)
                                )
                            ),
                          ),
                          OutlinedButton (
                            style: OutlinedButton.styleFrom(
                              shape: StadiumBorder(),
                              side: BorderSide(
                                  width: 1,
                                  color: Color(0xFF4BE3B0)
                              ),
                            ),
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            child: Text('Ajouter une photo', style: TextStyle(
                                color: Color(0xFF4BE3B0)
                            ),),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    ),
                  ),
                  const SizedBox(
                    width: 50,
                    height: 10,
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [

                                const SizedBox(
                                  width: 15,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                  authController.driverModel.value.plaqueImmatriculation == null?
                                  Expanded(
                                  child: TextField(
                                    controller: plaqueController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Plaque d'immatriculation",
                                        hintStyle: TextStyle(fontSize: 15)
                                    ),

                                  ),
                                ):
                                  Expanded(
                                    child: TextField(
                                      controller: plaqueController,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(fontSize: 15)
                                      ),

                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    ),
                  ),
                  const SizedBox(
                    width: 50,
                    height: 10,
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [

                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [

                                const SizedBox(
                                  width: 15,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                authController.driverModel.value.plaqueImmatriculation == null?
                                Expanded(
                                  child: TextField(
                                    controller: marqueController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Marque de voiture",
                                        hintStyle: TextStyle(fontSize: 15)
                                    ),

                                  ),
                                ):
                                Expanded(
                                  child: TextField(
                                    controller: marqueController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: 15)
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    ),
                  ),
                  const SizedBox(
                    width: 50,
                    height: 10,
                  ),
                  authController.driverModel.value.marqueVoiture == null?
                  ElevatedButton(
                    onPressed: () {
                      validateForm();
                      setState((){
                        isLoading = true;
                      });
                      storeUserInfo();
                    },
                    child: Text('Terminer'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(330, 45),
                        primary: Color(0xFF4BE3B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 10
                    ),):
                  ElevatedButton(
                    onPressed: () {
                      validateForm();
                      setState((){
                        isLoading = true;
                      });
                     updateUserInfo(
                         selectedImage,
                         plaqueController.text,
                         marqueController.text,
                         url: authController.driverModel.value.photoVoiture??""
                     );
                    },
                    child: Text('Update'),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(330, 45),
                        primary: Color(0xFF4BE3B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 10
                    ),),
                  const SizedBox(
                    width: 50,
                    height: 50,
                  ),
                ]
            ),
          ),
        )
    );
  }

  void validateForm() {}
}
