import 'package:flutter/material.dart';

class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('lib/assets/Profile.png'),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:  ElevatedButton(
                  onPressed: () async {

                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4BE3B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  child:  Text('Voiture'),),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:  ElevatedButton(
                  onPressed: () async {

                  },
                  child: Text('Coursier'),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4BE3B0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
