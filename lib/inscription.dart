import 'package:flutter/material.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 50),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Card(
                  child: ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                    title: Text("Information de base", style: TextStyle(fontSize: 15),),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>
                              InfoBase()));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                    title: Text("Permis de conduire", style: TextStyle(fontSize: 15),),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                    title: Text("Vérification de l'identité", style: TextStyle(fontSize: 15),),
                  ),
                ),
                Card(
                  child: ListTile(
                    trailing: Icon(Icons.keyboard_arrow_right, color: Color(0xFF4BE3B0)),
                    title: Text("Information véhicule", style: TextStyle(fontSize: 15),),
                  ),
                ),

              ],
            )


      ),
    );
  }
}

class InfoBase extends StatefulWidget {
  const InfoBase({Key? key}) : super(key: key);

  @override
  State<InfoBase> createState() => _InfoBaseState();
}

class _InfoBaseState extends State<InfoBase> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              child: Stack(
                children: [
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

