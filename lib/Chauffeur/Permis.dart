import 'package:flutter/material.dart';

class PermisChauffeur extends StatefulWidget {
  const PermisChauffeur({Key? key}) : super(key: key);

  @override
  State<PermisChauffeur> createState() => _PermisChauffeurState();
}

class _PermisChauffeurState extends State<PermisChauffeur> {

  validateForm(){

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
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Numéro Permis',
                                labelStyle:
                                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                  final Color color = states.contains(MaterialState.error)
                                      ? Theme.of(context).errorColor
                                      : const Color(0xFF4BE3B0);
                                  return TextStyle(color: color, letterSpacing: 1.3, fontSize: 15);
                                }),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(
                    width: 50,
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
                          Image.asset('lib/assets/card.png', width: 200, height: 100,),
                          OutlinedButton (
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size.fromWidth(25),
                              shape: StadiumBorder(),
                              side: BorderSide(
                                  width: 1,
                                  color: Color(0xFF4BE3B0)
                              ),
                            ),
                            onPressed: () { },
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
