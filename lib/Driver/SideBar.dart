import 'package:flutter/material.dart';
import 'package:wetrajet/Driver/AddTeam.dart';
import 'package:wetrajet/Driver/notifications.dart';
import 'package:wetrajet/Driver/profile.dart';

import '../model/User.dart';
import '../model/UserPreferences.dart';
import 'ProfileWidget.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Drawer(
      width: 250,


        child: ListView(

          physics: BouncingScrollPhysics(),

      children:<Widget> [


      Container(

        decoration:   BoxDecoration(

          borderRadius: BorderRadius.circular(20),

          gradient: const LinearGradient(

            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF4BE3B0),
              Color(0xFF4BE3B0),            ],



          ),
        ),


        child: Container(
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(2.0),
          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(100),


            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF4BE3B0),
                Colors.grey,
              ],



          ),
          ),
  child: ProfileWidget(
            imagePath: user.imagePath,
            onClicked :() async{}

        ),),),

        Container(
          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(80),

            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF4BE3B0),
                Colors.grey,
              ],



            ),
          ),

      ),

        ListTile(
          leading: const Icon(Icons.group
,  color: Colors.grey          ),
          title: const Text('Team',            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black),
          ),
          onTap:  () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTeam()),
          ),
        ),

        ListTile(
          leading: const Icon(Icons.notifications

              ,  color: Colors.grey          ),
          title: const Text('Notifications',
            style: TextStyle(fontStyle: FontStyle.italic ,color:Colors.black),
          ),
          onTap:  () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Notifications()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings

,  color: Colors.grey          ),
          title: const Text('Settings',
            style: TextStyle(fontStyle: FontStyle.italic ,color:Colors.black),
          ),
          onTap:  () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileChauffeur()),
          ),
        ),
        const Divider(

        ),
        const ListTile(
          title: Text('Logout'      ,

            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,),
        ),
          leading: Icon(Icons.exit_to_app
            ,  color: Colors.grey,

          ),

        ),
      ],
        ),
    );
  }
}



