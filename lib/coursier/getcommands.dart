import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Getcommands extends StatelessWidget {
  final String commands;

  Getcommands({required this.commands});


  @override
  Widget build(BuildContext context) {
    CollectionReference Commands = FirebaseFirestore.instance.collection("commandes");
    return FutureBuilder<DocumentSnapshot>(
      future: Commands.doc(commands).get() ,
      builder:((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map <String, dynamic>;
          return Text('${data['description']}') ;}

          return Text("loading ..");
      }),
        );
  }
}
