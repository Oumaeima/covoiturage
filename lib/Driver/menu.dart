import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';
import '../model/UserPreferences.dart';
import 'ProfileWidget.dart';

class Menu extends StatelessWidget {
  const Menu ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(




    body: ListView(
      physics: BouncingScrollPhysics(),
      children: [

        ProfileWidget(
            imagePath: user.imagePath,
            onClicked :() async{}

        ),
        const SizedBox(height: 24

        ),
        buildName(user),
        SizedBox(height: 24),
      ],
    )
    );


  }
  Widget buildName(User user)=>
      Column(
        children: [
          Text(
              user.name,
              style:  const TextStyle(fontSize: 24)),
          Text(
              user.email,
              style:  const TextStyle(color: Colors.grey)),

        ],
      );


}

