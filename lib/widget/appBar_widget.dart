import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF4BE3B0),),
      onPressed: () { Navigator.pop(context); },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}