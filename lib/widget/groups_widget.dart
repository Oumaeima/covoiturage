import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wetrajet/controller/groups_controller.dart';

class groupWidget extends StatefulWidget {
  const groupWidget({Key? key}) : super(key: key);

  @override
  State<groupWidget> createState() => _groupWidgetState();
}

class _groupWidgetState extends State<groupWidget> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("groups").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Container(
              margin: const EdgeInsets.only(top: 20),
              child: ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.transparent,),
                  itemBuilder: (context, index){
                    DocumentSnapshot groups = snapshot.data!.docs[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      //color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.do_not_disturb_on_total_silence_sharp, color: Color(0xFF4BE3B0),),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(groups["arrivé"], style: TextStyle(
                                    fontSize: 15
                                ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Image.asset("lib/assets/trajet.png", width: 25,),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset("lib/assets/dest.png", width: 24,),
                                const SizedBox(
                                  width: 20,
                                ),
                                 Text(groups["depart"], style: TextStyle(
                                    fontSize: 15
                                ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.7,
                              indent: 0,
                              endIndent: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on, color: Colors.grey,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(groups["prix"]+"DT"),
                                  ],
                                ),
                                TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      children: const [
                                        Text("Quit", style: TextStyle(color: Colors.black),),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined, color: Colors.grey, size: 15,)
                                      ],
                                    )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })
          );
        },

      )
    );
  }
}
