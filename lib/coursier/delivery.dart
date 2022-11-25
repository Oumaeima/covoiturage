import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);


  @override
  State<Delivery> createState() => _deliveryState();
}


class _deliveryState extends State<Delivery> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Les commandes" ,textAlign:TextAlign.center),
          backgroundColor: Color(0xFF4BE3B0),
          actions: [
        IconButton( onPressed: () {  },icon:Icon( Icons.exit_to_app)),

        ]),
       body: StreamBuilder <QuerySnapshot> (
         stream:FirebaseFirestore.instance.collection("commandes").snapshots(),
         builder:(context, snapshot){
           if (snapshot.hasError) {
             return Text('Something went wrong');
           }
           if (snapshot.connectionState == ConnectionState.waiting) {
             return CircularProgressIndicator();
           }
           return ListView.builder(
               padding: EdgeInsets.only(bottom: 70, top: 16),
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (context,index){
               DocumentSnapshot commandes = snapshot.data!.docs[index];
               return Card(
                 shadowColor: Colors.black,
                 color: Colors.greenAccent[100],
                   child: SizedBox(
                   width: 50,
                   height: 50,
               child:
                     Padding(
                       padding: const EdgeInsets.all(15.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                            Text(commandes["client id"].toString()),



                          ],
                       ),
                     ),

               ));

             }
           );
         },
       )

    );
  }
}

