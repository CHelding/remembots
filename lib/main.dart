import 'package:flutter/material.dart';
import 'package:remembots/Reminder.dart';
import 'package:remembots/ReminderListItem.dart';

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
  List<Reminder> reminders = new List();

  void addReminder() {
    setState(() {
      reminders.add(new Reminder("Gmail", "Respond to email", new DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Landing Page"), // Fix
      ), // consider moving this one layer up, to the Landing Page itself

      body: new ListView(
          children:
          reminders.map((Reminder reminder){
            return new ReminderItem(reminder);
          }).toList(),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: addReminder,
        tooltip: 'Add reminder',
        child: new Icon(Icons.add)
      ),
    );
  }

}