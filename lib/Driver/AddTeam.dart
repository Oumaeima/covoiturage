import 'package:flutter/material.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({Key? key}) : super(key: key);

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  @override
  Widget build(BuildContext context) {

      return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF4BE3B0) ,


            ),

          body:  Center(

          child: Container(
    margin: const EdgeInsets.all(100.0),
    decoration: const BoxDecoration(
    color: Color(0xFF4BE3B0),
    shape: BoxShape.circle
    ),
          ),
          )
        ),
      );
    }
  }

