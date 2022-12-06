import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wetrajet/Client/widget/navbarPassenger.dart';

class HomePassenger extends StatefulWidget {
  const HomePassenger({Key? key}) : super(key: key);

  @override
  State<HomePassenger> createState() => _HomePState();
}

class _HomePState extends State<HomePassenger> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: const Color(0xFF4BE3B0),),
          onPressed: (){},
        ),

      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Card(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.black.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Pacifico",
                                fontSize: 30
                            ),
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: Color(0xFF4BE3B0),
                              fontFamily: "Pacifico",
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Lottie.asset(
                          'lib/animations/car2.json',
                          height: size.height * 0.2,
                          repeat: false,
                          fit: BoxFit.contain,
                          alignment: Alignment.topRight
                      ),
                    ],
                  )
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 35,
                endIndent: 35,
                color: Colors.grey,
              ),
            ],
          ),
          NavBarPassenger()
        ],
      ),
    );
  }
}
