import 'package:flutter/material.dart';

void main() {
  runApp(new RemembotApp());
}

class RemembotApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Remembot App',
      theme: new ThemeData.dark(),
      home: new LandingPage(title: 'Landing Page'),
    );
  }
}

class LandingPage extends StatefulWidget {
  final String title;

  LandingPage({Key key, this.title}) : super(key: key);

  @override
  LandingPageState createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Landing Page"), // Fix
      ), // consider moving this one layer up, to the Landing Page itself

      body: new Center(
          child: new Text("No reminders yet..")
      ),

      floatingActionButton: new FloatingActionButton(
        //onPressed: ,
        tooltip: 'Increment',
        child: new Icon(Icons.add)
      ),
    );
  }
}

