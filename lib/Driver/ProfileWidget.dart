

import 'package:flutter/material.dart';
import 'package:wetrajet/Driver/AddTeam.dart';
import 'package:wetrajet/Driver/profile.dart';

import '../model/User.dart';
import '../model/UserPreferences.dart';


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget(
      {Key? key, required this.imagePath, required this.onClicked})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    // ignore: prefer_const_constructors
    final color = Color(0xFF4BE3B0);
    return  Stack(
        children  : [
     buildImage(),
     Positioned(
       bottom: 0,
        width: 40,
        height: 40,
        right: 160 ,
       child: buildEditImage(color,context),),
          Positioned(
            bottom: 0,
            width: 100,
            height: 100,
            right: 50 ,
            child:   buildName(user),),

          ]
          );






  }

   buildEditImage(Color color, BuildContext context) =>
      buildCercle(
          color: Colors.white,
          all: 4,
          child: buildCercle(
            color:color,
            all: 1,
            child:  IconButton(

              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileChauffeur()),
              ),
            ),





          ));

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(

      child: Material(
        color: Color( 0xFF4BE3B0),


        child:Container(

         child: Ink.image(image: image,
          fit: BoxFit.cover,
          width: 60,
          height: 80,

        ),
      ),
          ));
  }

  Widget buildCercle({
    required Widget child,
    required double all,
    required Color color,}) =>
      ClipOval(

        child: Container(
            padding: EdgeInsets.all(all),
            color: color,
            child: child
        ),
      );


} Widget buildName(User user)=>

    Container(

        alignment: Alignment.bottomLeft,

        child:Center(
            child: Text (

              user.name,
              style: const TextStyle(fontFamily: 'DancingScript',color:Colors.white,fontSize: 15,height: 5 ),


            ))
    );
