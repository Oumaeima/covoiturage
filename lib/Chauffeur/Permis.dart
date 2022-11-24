import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PermisChauffeur extends StatefulWidget {
  const PermisChauffeur({Key? key}) : super(key: key);

  @override
  State<PermisChauffeur> createState() => _PermisChauffeurState();
}

class _PermisChauffeurState extends State<PermisChauffeur> {

  final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker2 = ImagePicker();
  File? selectedImage1;
  File? selectedImage2;

  TextEditingController dateController = TextEditingController();
  TextEditingController permisController = TextEditingController();

  getImage1(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if(image != null){
      selectedImage1 = File(image.path);
      setState((){

      });
    }
  }

  getImage2(ImageSource source) async {
    final XFile? image2 = await _picker2.pickImage(source: source);
    if(image2 != null){
      selectedImage2 = File(image2.path);
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
    String recto = await uploadImage(selectedImage1!);
    String verso = await uploadImage(selectedImage2!);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("driver").doc(uid).update({
      'recto-permis': recto,
      'verso-permis': verso,
      'num-permis' : permisController.text,
      'expiration-permis': dateController.text,
    }).then((value){
      permisController.clear();
      dateController.clear();
      isLoading = false;
      Navigator.pushNamed(context, "infoV");
    });
  }
  validateForm(){

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
      appBar: AppBar(
        title: Text("Permis de conduire"),
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
                                Expanded(
                                  child: TextField(
                                    controller: permisController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Numéro Permis",
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
                          Text("Recto du permis de conduire"),
                          selectedImage1 == null? Image.asset('lib/assets/card.png', width: 200, height: 100,):
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(selectedImage1!)
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
                              getImage1(ImageSource.camera);
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
                          Text("Verso du permis de conduire"),
                          selectedImage2 == null? Image.asset('lib/assets/card.png', width: 200, height: 100,):
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(selectedImage2!)
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
                              getImage2(ImageSource.camera);
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
                                      hintText: "Date d'expiration",
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
                    onPressed: () {
                      validateForm();
                      setState((){
                        isLoading = true;
                      });
                      storeUserInfo();
                    },
                    child: Text('Next'),
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
}
