import 'package:flutter/material.dart';
//import 'package:remembots/protofiTheme.dart' as Theme;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:remembots/Reminder.dart';
import 'package:intl/intl.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

void main() {
  runApp(new RemembotApp());
}

/*If the value of the currentUser property is null, your app will first execute signInSilently(),
get the result and store it in the user variable. The signInSilently method attempts to sign in a previously authenticated user,
without interaction. After this method finishes executing, if the value of user is still null,
your app will start the sign-in process by executing the signIn() method.
After a user signs in, we can access the profile photo from the GoogleSignIn instance.
 */
Future<Null> ensureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null)
    user = await googleSignIn.signInSilently();
  if (user == null) {
    await googleSignIn.signIn();
  }

  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credentials =
    await googleSignIn.currentUser.authentication;
    await auth.signInWithGoogle(
      idToken: credentials.idToken,
      accessToken: credentials.accessToken,
    );
  }
}





class RemembotApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Remembot App',
      theme: new ThemeData.light(),
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

  /*void sendMessage({ String text }) {
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }*/

  void addReminder() {
    for (Reminder reminder in reminders) {
      reminder.isExpanded = false;
    }

    setState(() {}); //Ensures redraw of this widget

    Navigator.of(context).pushNamed("/CreateReminderPage");
  }

  static void submitReminder(bool isExpanded, Color avatarColor, String name, String description, DateTime creationDate) {
    reminders.add(new Reminder(isExpanded, avatarColor, name, description, creationDate));
  }

  void editReminder() {
    //setState(() {}); //Ensures redraw of this widget
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[50],

      drawer: new AppDrawer(),

      appBar: new AppBar(
        title: new Text("Your reminders"), // Fix
        backgroundColor: Colors.blueGrey[900],
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
                          style: new TextStyle(color: Colors.white)
                        ),
                        backgroundColor: reminder.avatarColor,
                      ),

                      title: new Text(
                        reminder.name,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
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
                              textScaleFactor: 1.1,
                            )
                          )
                        ]
                      ),

                      new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Row(
                          children: <Widget>[

                            new IconButton(
                              icon: new Icon(Icons.edit),
                              color: Colors.blueGrey[400],
                              onPressed: editReminder,
                            ),

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
                            ),

                            new IconButton(
                              icon: new Icon(Icons.delete),
                              color: Colors.blueGrey[400],
                              onPressed: () { setState(() {reminders.remove(reminder);});},
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
        child: new Icon(Icons.add),
        backgroundColor: Colors.blueGrey[900],
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
            child: new Image.network(googleSignIn.currentUser.photoUrl)
          ),

          new ListTile(
            title: new Text("Item 1")
          )
        ],
      )
    );
  }
}





class CreateReminderPage extends StatefulWidget {
  final String title;

  CreateReminderPage({Key key, this.title}) : super(key: key);

  @override
  CreateReminderPageState createState() => new CreateReminderPageState();
}






class CreateReminderPageState extends State<CreateReminderPage> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController description = new TextEditingController();

  bool isComposing = false;

  Color pickerColor = new Color(0xff443a49);
  Color currentColor = new Color(0xff443a49);

  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  void checkFields(){
    if(name.text.isNotEmpty && description.text.isNotEmpty) {
      handleSubmitted(false, name.text, description.text);
      Navigator.of(context).pop();

    } else {
      showDialog(
          context: context,
          child: new AlertDialog(
              title: const Text("Oops"),
              content: new Text("Seems you forgot what it is, that you need to remember!")
          )
      );
    }
  }

  Future<Null> handleSubmitted(bool isExpanded, String name, String description) async {
    await ensureLoggedIn();

    LandingPageState.submitReminder(false, pickerColor, name, description, new DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Create reminder"), // Fix
          backgroundColor: Colors.blueGrey[900],
        ),

        body: new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              new Container(
                margin: new EdgeInsets.only(bottom: 40.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.white,
                    width: 1.0,
                  ),
                  borderRadius: new BorderRadius.circular(8.0),
                  color: pickerColor,
                ),
                width: 100.0,
                height: 100.0,
              ),

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
                    pickerColor = currentColor;
                    showDialog(
                      context: context,
                      child: new AlertDialog(
                        title: const Text('Pick a color!'),

                        content: new SingleChildScrollView(
                          child: new ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: changeColor,
                            colorPickerWidth: 1000.0,
                            pickerAreaHeightPercent: 0.7,
                          ),
                        ),

                        actions: <Widget>[
                          new FlatButton(
                            child: new Text('Got it'),
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: new Text('CHOOSE YOUR COLOR'),
                  color: Colors.blueGrey[900],
                  textColor: Colors.white,
                ),
              ),

              new Padding(
                padding: new EdgeInsets.only(top: 20.0, bottom: 100.0),
                child: new RaisedButton(
                  onPressed: () {
                    checkFields();
                  },
                  child: new Text('DONE'),
                  color: Colors.blueGrey[900],
                  textColor: Colors.white,
                ),
              )

            ],
          )
        )
    );
  }
}