import 'package:flutter/material.dart';

class Compte extends StatefulWidget {
  const Compte({Key? key}) : super(key: key);

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25, top: 160),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('lib/assets/goride.png'),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child:  ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, "phone");
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF4BE3B0), width: 1),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text('Passager', style: TextStyle(
                    color: Colors.black
                  )),),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child:  ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, "phone");
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF4BE3B0), width: 1),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child: const Text('Chauffeur', style: TextStyle(
                      color: Colors.black
                  )),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
