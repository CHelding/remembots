import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remembots/Reminder.dart';

class ReminderItem extends StatelessWidget {
  final Reminder reminder;

  ReminderItem(this.reminder);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),

      child: new Column(
        children: <Widget>[

          new Row(
            children: <Widget>[
              new CircleAvatar(
                  child: new Text(reminder.name[0])
              ),
              new Expanded(
                  child: new Text(
                    reminder.name.toString(),
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                  )
              ),
              new IconButton(
                    //onPressed: addReminder,
                    tooltip: 'Open reminder',
                    icon: new Icon(Icons.arrow_drop_down_circle)
              ),
            ],
          ),

          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(children: <Widget>[
                    new Text(
                      new DateFormat.yMMMMd().format(reminder.dueDate),
                      textScaleFactor: 0.9,
                      textAlign: TextAlign.left,
                    ),
                    new Text(
                      new DateFormat.EEEE().format(reminder.dueDate),
                      textScaleFactor: 0.8,
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],)
              )
            ],
          ),

        ],
      ),
    );
  }
}