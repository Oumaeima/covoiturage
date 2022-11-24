import 'package:flutter/material.dart';
import 'package:wetrajet/widget/navbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(
            Icons.settings,
            color: Color(0xFF4BE3B0),
          ))
        ],
      ),
      body: Stack(
        children: [
          NavBar()
        ],
      ),
    );
  }
}

