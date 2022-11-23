import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


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
      'email': emailController.text
    }).then((value){
      fullNameController.clear();
      dateController.clear();
      emailController.clear();
      isLoading = false;
      Navigator.pushNamed(context, "permisC");
    });
  }

  validateForm() {
    if (fullNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: " Name must be at least 3 characters");
    }
    else if (!emailController.text.contains("@") || emailController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Email incorrect");
    }
    else if (dateController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    }

    else {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext c) {
            return Progress_dialog(message: 'We are registering ...please wait');
          });
    }
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    dateController.text="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 50),
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
                            backgroundImage: AssetImage('lib/assets/homme.png'),
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
                                  child: TextField(
                                    controller: fullNameController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Full Name"
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
                                  child: TextField(
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
                                  child: TextField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "E-mail"
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
                  isLoading? Center(child: CircularProgressIndicator(),): ElevatedButton(
                    onPressed: () async{
                   /*   FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) async {

                        if (user != null) {
                          print(user.uid);
                          FirestoreService.AuthCredential(name: fullNameController.text, email: emailController.text);
                        }
                      });*/
                      validateForm();
                      //Navigator.pushNamed(context, "permisC");
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
                    child: const Text('Next'),),

                ]
            ),
          ),
        )
    );
  }
}

class Progress_dialog extends StatelessWidget{
  String? message;
  Progress_dialog({this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(padding: const
        EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(width: 3.0,),
              const CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(width : 26.0),
              Text(message!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,

                ),
              )

            ],

          ),
        ),
      ),
    );

  }
}