import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dialogs.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class Page1 extends StatefulWidget {
  @override
  Feelings createState() => Feelings("Feelings");
}

/**
 * what happens when the Feelings tab is open
 */

class Feelings extends State<Page1> {
  final String title;
  static AudioCache player = AudioCache();

  Feelings(this.title);

  Dialogs dialogs = new Dialogs();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
          backgroundColor: Colors.red[900],
        ),
        backgroundColor: Color.fromRGBO(HomePageState.redCount,
            HomePageState.greenCount, HomePageState.blueCount, 1),
        body: Center(
            child: Container(
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                new FlatButton(
                  child: Image.asset('assets/images/Happy.gif',
                      width: 120, height: 120),
                  onPressed: () {
                    player.play('audio/meow.mp3');
                    HomePageState.setGreen();
                    HomePageState.result[1]++;
                    print('red:');
                    print(HomePageState.redCount);
                    print('blue:');
                    print(HomePageState.blueCount);
                    HomePageState.update();
                    setState(() {
                      HomePageState.setColor();
                    });
                  },
                )
              ]),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new FlatButton(
                    child: Image.asset('assets/images/Sad.gif',
                        width: 120, height: 120),
                    onPressed: () {
                      HomePageState.setBlue();
                      HomePageState.result[2]++;
                      print('red');
                      print(HomePageState.redCount);
                      print('green');
                      print(HomePageState.greenCount);
                      HomePageState.update();
                      setState(() {
                        HomePageState.setColor();
                      });
                    },
                  ),
                  new FlatButton(
                    child: Image.asset('assets/images/Angry.gif',
                        width: 120, height: 120),
                    onPressed: () {
                      HomePageState.setRed();
                      HomePageState.result[0]++;
                      print('green');
                      print(HomePageState.greenCount);
                      print('blue');
                      print(HomePageState.blueCount);
                      HomePageState.update();
                      setState(() {
                        HomePageState.setColor();
                      });
                    },
                  ),
                ],
              ),
              new FlatButton(
                  child: new Text("Statistics"),
                  color: Colors.white,
                  onPressed: () {
                    HomePageState.update();
                    dialogs.information(
                        context,
                        "Your Anger/Happiness/Sadness Levels are: ",
                        HomePageState.result.toString());
                  }),
              new FlatButton(
                child: new Text("Reset"),
                color: Colors.white,
                onPressed: () {
                  HomePageState.reset();
                  print(HomePageState.redCount);
                  print(HomePageState.greenCount);
                  print(HomePageState.blueCount);
                  HomePageState.update();
                  setState(() {
                    HomePageState.setColor();
                  });
                },
              ),
            ],
          ),
        )));
  }
}
