import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  AppDrawerState createState() => new AppDrawerState();
}



class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: new ListView(
          children: <Widget>[

            new DrawerHeader(
                child: new Text("Picture goes here") //new Image.network(googleSignIn.currentUser.photoUrl) // consider getting in main and saving to variable
            ),

            new ListTile(
                title: new Text("Item 1")
            ),
          ],
        )
    );
  }
}