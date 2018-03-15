import 'package:flutter/material.dart';
import 'package:remembots/Reminder.dart';
import 'package:intl/intl.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

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
      routes: <String, WidgetBuilder> {
        "/LandingPage": (BuildContext context) => new LandingPage(),
        "/CreateReminderPage": (BuildContext context) => new CreateReminderPage()
      },
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
  static List<Reminder> reminders = new List();
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  void addReminder() {
    for (Reminder reminder in reminders) {
      reminder.isExpanded = false;
    }

    setState(() {}); //Ensures redraw of this widget

    Navigator.of(context).pushNamed("/CreateReminderPage");
  }

  static void submitReminder(bool isExpanded, String name, String description, DateTime creationDate) {
    reminders.add(new Reminder(isExpanded, name, description, creationDate));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Landing Page"), // Fix
      ), // consider moving this one layer up, to the Landing Page itself

      body: new ListView(
        children: [
          new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new ExpansionPanelList(

              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  reminders[index].isExpanded = !reminders[index].isExpanded;
                });
              },

              children: reminders.map((Reminder reminder) {
                return new ExpansionPanel(

                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return new ListTile(
                      leading: new CircleAvatar(
                        child: new Text(
                          reminder.name[0],
                          textAlign: TextAlign.left,
                        )
                      ),

                      title: new Text(
                        reminder.name,
                        textAlign: TextAlign.center,
                      )
                    );
                  },
                  isExpanded: reminder.isExpanded,

                  body: new Column(
                    children: <Widget>[

                      new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Text(
                              reminder.description,
                              textAlign: TextAlign.center,
                            )
                          )
                        ]
                      ),

                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Column(children: <Widget>[
                                new Text(
                                  new DateFormat.yMMMMd().format(reminder.creationDate),
                                  textScaleFactor: 0.9,
                                  textAlign: TextAlign.center,
                                ),
                                new Text(
                                  new DateFormat.EEEE().format(reminder.creationDate),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],)
                            )
                          ]
                        ),
                      ),

                    ],
                  )

                );
              }).toList(),
            )
          ),
        ]
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: addReminder,
        tooltip: 'Add reminder',
        child: new Icon(Icons.add)
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    var result;

    super.initState();
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {

      result = event.x.abs() + event.y.abs() + event.z.abs();

      setState(() {
        if(result > 30) {
          reminders.shuffle();
        }
      });

    }));
  }
}

class CreateReminderPage extends StatelessWidget {
  final TextEditingController name = new TextEditingController();
  final TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Create reminder"), // Fix
        ),

        body: new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new TextField(
                controller: name,
                decoration: new InputDecoration(
                  hintText: 'Name',
                ),
              ),

              new TextField(
                controller: description,
                decoration: new InputDecoration(
                  hintText: 'Description',
                ),
              ),

              new Padding(
                padding: new EdgeInsets.only(top: 20.0),
                child: new RaisedButton(
                  onPressed: () {
                    LandingPageState.submitReminder(false, name.text, description.text, new DateTime.now());
                    Navigator.of(context).pop();
                  },
                  child: new Text('DONE'),
                ),
              )

            ],
          )
        )
    );
  }
}