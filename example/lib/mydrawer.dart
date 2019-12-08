import 'package:flutter/material.dart';
import 'listvideo.dart';
import 'home_page.dart';
import 'playlist.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(Playlist.isMovie) {
      return new Drawer(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              new Divider(),
              new ListMenu(
                title: HomePageState.currTitle,
                url: HomePageState.movieUrl,
              ),
            ],
          ),
        ),
      );
    }
    else {
      return new Drawer(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              new Divider(),
              new ListMenu(
                title: HomePageState.currTitle,
                url: HomePageState.currUrl,
              ),
            ],
          ),
        ),
      );
    }
  }
}

class ListMenu extends StatelessWidget {
  ListMenu({this.title, this.url});
  final String title;
  final String url;
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Icon(Icons.video_library),
      title: new Text(
        title,
        style: new TextStyle(fontSize: 18.0),
      ),
      onTap: () => Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (BuildContext context) => new ListVideo(
            url: url,
            title: title,
          ),
        ),
      ),
    );
  }
}
