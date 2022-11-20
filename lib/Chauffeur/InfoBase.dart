import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('lib/assets/homme.png'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            //height: 45,
                            //width: double.infinity,
                            child:  ElevatedButton(
                              onPressed: () async {

                              },
                              child: Text('Ajouter une photo*'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF4BE3B0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)
                                  )
                              ),),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children:  [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
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
                                    decoration: InputDecoration(
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

                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children:  [
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
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
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "E-mail"
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      validateForm();
                      Navigator.pushNamed(context, "permisC");
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