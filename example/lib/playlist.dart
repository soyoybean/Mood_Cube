import 'package:flutter/material.dart';
import 'home_page.dart';
import 'mydrawer.dart';
import 'listvideo.dart';

class Page2 extends StatefulWidget {
  @override
  Playlist createState() => Playlist("Playlist");
}

/**
 * what happens when the Settings tab is open
 */

class Playlist extends State<Page2> {
  final String title;
  static bool isMovie;

  Playlist(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(
        title: new Text(title),
        backgroundColor: Colors.blueAccent[900],
      ),
      backgroundColor: Color.fromRGBO(HomePageState.redCount,
          HomePageState.greenCount, HomePageState.blueCount, 1),
      body: new Container(
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(
                width: 150.0,
                height: 150.0,
                child: new Image.asset("assets/images/icn.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
