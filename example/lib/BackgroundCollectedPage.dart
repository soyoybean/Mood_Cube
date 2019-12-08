import 'package:flutter/material.dart';

import './BackgroundCollectingTask.dart';
import './helpers/LineChart.dart';
import './helpers/PaintStyle.dart';

class BackgroundCollectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task = BackgroundCollectingTask.of(context, rebuildOnChange: true);


    return Scaffold(
      appBar: AppBar(
        title: Text('Collected data'),
        actions: <Widget>[
          // Progress circle
          (
            task.inProgress ?
              FittedBox(child: Container(
                margin: new EdgeInsets.all(16.0),
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              ))
            :
              Container(/* Dummy */)
          ),
          // Start/stop buttons
          (
            task.inProgress ?
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: task.pause
              )
            :
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: task.reasume
              )
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Divider(),
          ListTile(
            leading: const Icon(Icons.brightness_7),
            title: const Text('Temperatures'),
            subtitle: const Text('In Celsius'),
          ),

          Divider(),
          ListTile(
            leading: const Icon(Icons.filter_vintage),
            title: const Text('Water pH level'),
          ),
        ],
      )
    );
  }
}
