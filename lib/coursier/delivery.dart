import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wetrajet/coursier/getcommands.dart';


class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);


  @override
  State<Delivery> createState() => _deliveryState();
}


class _deliveryState extends State<Delivery> {
  @override
 //commandes IDs
  List<String> commandesId =[];

// Get commandesID
 Future getCommandsList() async {
     await FirebaseFirestore.instance.collection("commandes").get().then(
             (snapshot) => snapshot.docs.forEach((document) {
           print(document.reference);
           commandesId.add(document.reference.id);
         }));

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommandsList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Color(0xFF4BE3B0),
            title: Text("Les commandes")),

      body: FutureBuilder(
          future: getCommandsList() ,
          builder:(context, snapshot) {
        return ListView.builder(
        itemCount: commandesId.length,
    itemBuilder: (context,index){
    return ListTile(
        trailing: IconButton(onPressed: (){}, 
          icon:Icon(Icons.verified_sharp)),
        subtitle: Getcommands(commands:commandesId[index],


    )
    );
    });
    }
      )
    );
  }
}

