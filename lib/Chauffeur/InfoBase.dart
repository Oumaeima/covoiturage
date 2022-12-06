import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wetrajet/widget/appBar_widget.dart';
import '../controller/auth_controller.dart';


class InfoBase extends StatefulWidget {
  const InfoBase({Key? key}) : super(key: key);

  @override
  State<InfoBase> createState() => _InfoBaseState();
}

class _InfoBaseState extends State<InfoBase> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

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
    String url = await uploadImage(selectedImage!);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).set({
      'image': url,
      'userId': uid,
      'name' : fullNameController.text,
      'birthday': dateController.text,
      'email': emailController.text,
    }).then((value){
      fullNameController.clear();
      dateController.clear();
      emailController.clear();
      isLoading = false;
      Navigator.pushNamed(context, "permisC");
    });
  }

  updateUserInfo(File? image, String name, String date, String email,{String url = ''}) async{
    String new_url = url;
    if(image != null){
       new_url = await uploadImage(image);
    }
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).update({
      'image': new_url,
      'userId': uid,
      'name' : fullNameController.text,
      'birthday': dateController.text,
      'email': emailController.text,
      'role': "driver"
    }).then((value){
      fullNameController.clear();
      dateController.clear();
      emailController.clear();
      isLoading = false;
      Navigator.pushNamed(context, "profileC");
    });
  }

  validateForm() {

  }

  AuthController authController = Get.put(AuthController());


  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    dateController.text="";
    authController.getUserInfo();
    fullNameController.text = authController.driverModel.value.name??"";
    dateController.text = authController.driverModel.value.birthday??"";
    emailController.text = authController.driverModel.value.email??"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                           selectedImage == null? CircleAvatar(
                            radius: 50,
                             backgroundImage: authController.driverModel.value.image == null?
                                 AssetImage('lib/assets/homme.png')
                                 : NetworkImage(authController.driverModel.value.image!) as ImageProvider,
                          ): CircleAvatar(
                             radius: 50,
                             backgroundImage: FileImage(selectedImage!),
                           ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton (
                            style: OutlinedButton.styleFrom(
                              shape: const StadiumBorder(),
                              side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFF4BE3B0)
                              ),
                            ),
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            child: const Text('Ajouter une photo', style: TextStyle(
                                color: Color(0xFF4BE3B0)
                            ),),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children:  [
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  width: 15,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: authController.driverModel.value.name == null? TextField(
                                    controller: fullNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Full Name"
                                    ),
                                  ): TextField(
                                    controller: fullNameController,
                                    keyboardType: TextInputType.name,
                                    decoration:  InputDecoration(
                                        border: InputBorder.none,
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
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
                              children:  [

                                const SizedBox(
                                  width: 15,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: authController.driverModel.value.birthday == null?
                                  TextField(
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Enter Date",
                                      icon : Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                    onTap: () async{
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), //get today's date
                                        firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101),
                                      );

                                      if(pickedDate != null ){
                                        print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                        //You can format date as per your need

                                        setState(() {
                                          dateController.text = formattedDate; //set formatted date to TextField value.
                                        });
                                      }else{
                                        print("Date is not selected");
                                      }
                                    },
                                  )
                                  :TextField(
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon : Icon(Icons.calendar_today),
                                    ),
                                    readOnly: true,
                                    onTap: () async{
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), //get today's date
                                        firstDate:DateTime(1950), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101),
                                      );

                                      if(pickedDate != null ){
                                        print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                        //You can format date as per your need

                                        setState(() {
                                          dateController.text = formattedDate; //set formatted date to TextField value.
                                        });
                                      }else{
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
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
                              children:  [
                                const SizedBox(
                                  width: 10,
                                ),
                                const SizedBox(
                                  width: 15,
                                  child: TextField(

                                    decoration: InputDecoration(
                                        border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: authController.driverModel.value.email == null?
                                  TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "E-mail"
                                    ),
                                  ):
                                  TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
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
                authController.driverModel.value.name == null?
                  ElevatedButton(
                    onPressed: () async{
                      setState((){
                        isLoading = true;
                      });
                      storeUserInfo();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(330, 45),
                        primary: const Color(0xFF4BE3B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 10
                    ),
                    child: const Text('Next'),
                  ):
                  ElevatedButton(
                    onPressed: () async{
                      setState((){
                        isLoading = true;
                      });
                      updateUserInfo(
                        selectedImage,
                        fullNameController.text,
                        dateController.text,
                        emailController.text,
                        url: authController.driverModel.value.image??""
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(330, 45),
                        primary: const Color(0xFF4BE3B0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 10
                    ),
                    child: const Text('Update'),
                  ),

                ]
            ),
          ),
        )
    );
  }
}

