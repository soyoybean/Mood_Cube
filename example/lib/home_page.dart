import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:gapless_audio_loop/gapless_audio_loop.dart';

import 'feelings.dart';
import 'playlist.dart';
import 'MainPage.dart';
import 'playlist.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  static Random rand = new Random(30);
  static String currentProfilePic =
      "https://github.com/libgit2/libgit2sharp/raw/master/square-logo.png";
  static String otherProfilePic =
      "https://github.com/libgit2/libgit2sharp/raw/master/square-logo.png";
  static int red_MAX = 100;
  static int green_MAX = 100;
  static int blue_MAX = 100;
  static int total_MAX = red_MAX + green_MAX + blue_MAX;
  static int redCount = 255;
  static int greenCount = 255;
  static int blueCount = 255;
  static List<int> result = [0, 0, 0];
  static int totalCount = redCount + greenCount + blueCount;
  static int change = 10;
  static double x_position1 = 30;
  static double y_position1 = 160;
  static double x_position2 = 137;
  static double y_position2 = 160;
  static double x_position3 = 247; //rand.nextDouble() * 260;
  static double y_position3 = 160; //rand.nextDouble() * 370;
  static String mood = 'default';
  static String catPose = 'assets/cats/Default.png';
  static String catPoseOutline = 'assets/cats/DefaultOutline.png';
  static double catPositionX = 0;
  static double catPositionY = 50;
  static double catYAlignment = 7.3;
  static String currUrl = "https://happyplaylist.herokuapp.com/";
  static String movieUrl = "SOME URL";
  static String currTitle = HomePageState.mood;
  static List<String> url = [
    "https://defaultplaylist.herokuapp.com/",
    "https://angryplaylist.herokuapp.com/",
    "https://excitedplaylist.herokuapp.com/",
    "https://sorrowplaylist.herokuapp.com/",
    "https://sadplaylist.herokuapp.com/",
    "https://relaxedplaylist.herokuapp.com/",
    "https://anxiousplaylist.herokuapp.com/",
    "https://happyplaylist.herokuapp.com/",
    "https://defaultmovie.herokuapp.com/",
    "https://happymovie.herokuapp.com/",
    "https://sadmovie.herokuapp.com/",
    "https://sorrowmovie.herokuapp.com/",
    "https://angermovie.herokuapp.com/",
    "https://excitedmovie.herokuapp.com/",
    "https://anxiousmovie.herokuapp.com/",
    "https://relaxedmovie.herokuapp.com/"
  ];
  static GaplessAudioLoop homeAudio;

  static Color color = Color.fromRGBO(
      255 * (1 - (totalCount / total_MAX) * (redCount / totalCount)).round(),
      255 * (1 - (totalCount / total_MAX) * (greenCount / totalCount)).round(),
      255 * (1 - (totalCount / total_MAX) * (blueCount / totalCount)).round(),
      1);

  static Color getColor() {
    return color;
  }

  static void setColor() {
    color = Color.fromRGBO(
        255 * (1 - (totalCount / total_MAX) * (redCount / totalCount)).round(),
        255 *
            (1 - (totalCount / total_MAX) * (greenCount / totalCount)).round(),
        255 * (1 - (totalCount / total_MAX) * (blueCount / totalCount)).round(),
        0.6);
  }

  static int getRed() {
    return redCount;
  }

  static void setRed() {
    if (redCount <= 255 - change) redCount += change;
    if (greenCount >= change) greenCount -= change;
    if (blueCount >= change) blueCount -= change;
    setTotal();
  }

  static int getGreen() {
    return greenCount;
  }

  static void setGreen() {
    if (greenCount <= 255 - change) greenCount += change;
    if (redCount >= change) redCount -= change;
    if (blueCount >= change) blueCount -= change;
    setTotal();
  }

  static int getBlue() {
    return blueCount;
  }

  static void setBlue() {
    if (blueCount <= 255 - change) blueCount += change;
    if (redCount >= change) redCount -= change;
    if (greenCount >= change) greenCount -= change;
    setTotal();
  }

  static void setTotal() {
    totalCount = redCount + greenCount + blueCount;
  }

  static void reset() {
    redCount = 255;
    greenCount = 255;
    blueCount = 255;
    result = [0, 0, 0];
  }

  loadResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      result[0] = (prefs.getInt('result0') ?? 0);
      result[1] = (prefs.getInt('result1') ?? 0);
      result[2] = (prefs.getInt('result2') ?? 0);
    });
  }

  loadMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mood = (prefs.getString('mood') ?? "Default");
      catPose = (prefs.getString('catPose') ?? 'assets/cats/Default.png');
      catPoseOutline = (prefs.getString('catPoseOutline') ??
          'assets/cats/DefaultOutline.png');
    });
  }

  loadPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      catPositionX = (prefs.getDouble('catPositionX') ?? 10);
      catPositionY = (prefs.getDouble('catPositionY') ?? 55);
      catYAlignment = (prefs.getDouble('catYAlignment') ?? 8.7);
    });
  }

  loadUrls() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currUrl = (prefs.getString('currUrl') ?? url[0]);
      movieUrl = (prefs.getString('movieUrl') ?? url[8]);
      currTitle = (prefs.getString('title') ?? "default");
    });
  }

  static void setMood() {
    if (HomePageState.redCount <= (255 * 0.5).round() &&
        HomePageState.greenCount <= (255 * 0.5).round() &&
        HomePageState.blueCount <= (255 * 0.5).round()) {
      HomePageState.mood = "Anxious";
      catPose = 'assets/cats/Anxious.png';
      catPoseOutline = 'assets/cats/AnxiousOutline.png';
      catYAlignment = 7.3;
    } else if (HomePageState.redCount <= (255 * 0.5).round() &&
        HomePageState.greenCount >= (255 * 0.5).round() &&
        HomePageState.blueCount <= (255 * 0.5).round()) {
      HomePageState.mood = "Happy";
      catPose = 'assets/cats/Happy.png';
      catPoseOutline = 'assets/cats/HappyOutline.png';
      catYAlignment = 8.0; //done
    } else if (HomePageState.redCount >= (255 * 0.5).round() &&
        HomePageState.greenCount <= (255 * 0.5).round() &&
        HomePageState.blueCount <= (255 * 0.5).round()) {
      HomePageState.mood = "Anger";
      catPose = 'assets/cats/Anger.png';
      catPoseOutline = 'assets/cats/AngerOutline.png';
      catPositionX = 10;
      catPositionY = 75;
      catYAlignment = 5.7; //done
    } else if (HomePageState.redCount <= (255 * 0.5).round() &&
        HomePageState.greenCount <= (255 * 0.5).round() &&
        HomePageState.blueCount >= (255 * 0.5).round()) {
      HomePageState.mood = "Sad";
      catPose = 'assets/cats/Sad.png';
      catPoseOutline = 'assets/cats/SadOutline.png';
      catYAlignment = 6.5; //done
    } else if (HomePageState.redCount >= (255 * 0.5).round() &&
        HomePageState.greenCount <= (255 * 0.5).round() &&
        HomePageState.blueCount >= (255 * 0.5).round()) {
      HomePageState.mood = "Sorrow";
      catPose = 'assets/cats/Sorrow.png';
      catPoseOutline = 'assets/cats/SorrowOutline.png';
      catYAlignment = 6.6; //done
    } else if (HomePageState.redCount <= (255 * 0.5).round() &&
        HomePageState.greenCount >= (255 * 0.5).round() &&
        HomePageState.blueCount >= (255 * 0.5).round()) {
      HomePageState.mood = "Relaxed";
      catPose = 'assets/cats/Relaxed.png';
      catPoseOutline = 'assets/cats/RelaxedOutline.png';
      catYAlignment = 7.1; //done
    } else if (HomePageState.redCount >= (255 * 0.5).round() &&
        HomePageState.greenCount >= (255 * 0.5).round() &&
        HomePageState.blueCount <= (255 * 0.5).round()) {
      HomePageState.mood = "Excited";
      catPose = 'assets/cats/Excited.png';
      catPoseOutline = 'assets/cats/ExcitedOutline.png';
      catPositionX = 10;
      catPositionY = 50;
      catYAlignment = 12.6; //done
    } else if (HomePageState.redCount > (255 * 0.5).round() &&
        HomePageState.greenCount > (255 * 0.5).round() &&
        HomePageState.blueCount > (255 * 0.5).round()) {
      HomePageState.mood = "Default";
      catPose = 'assets/cats/Default.png';
      catPoseOutline = 'assets/cats/DefaultOutline.png';
      catPositionX = 10;
      catPositionY = 55;
      catYAlignment = 8.7; //done
    }
  }

  static setUrl() async{
    SharedPreferences refs = await SharedPreferences.getInstance();
    if (HomePageState.mood.compareTo("Happy") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[7];
      movieUrl = url[9];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[7]);
      refs.setString("movieUrl", url[9]);
    } else if (HomePageState.mood.compareTo("Sad") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[4];
      movieUrl = url[10];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[4]);
      refs.setString("movieUrl", url[10]);
    } else if (HomePageState.mood.compareTo("Anger") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[1];
      movieUrl = url[12];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[1]);
      refs.setString("movieUrl", url[12]);
    } else if (HomePageState.mood.compareTo("Relaxed") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[5];
      movieUrl = url[15];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[5]);
      refs.setString("movieUrl", url[15]);
    } else if (HomePageState.mood.compareTo("Sorrow") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[3];
      movieUrl = url[11];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[3]);
      refs.setString("movieUrl", url[11]);
    } else if (HomePageState.mood.compareTo("Excited") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[2];
      movieUrl = url[13];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[2]);
      refs.setString("movieUrl", url[13]);
    } else if (HomePageState.mood.compareTo("Anxious") == 0) {
      currTitle = HomePageState.mood;
      currUrl = url[6];
      movieUrl = url[14];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[6]);
      refs.setString("movieUrl", url[14]);
    } else {
      currTitle = HomePageState.mood;
      currUrl = url[0];
      movieUrl = url[8];
      refs.setString("title",  HomePageState.mood);
      refs.setString("currUrl", url[0]);
      refs.setString("movieUrl", url[8]);
    }
  }

  static String setHomeAudio() {
    if (HomePageState.mood.compareTo("happy") == 0) {
      return "Happy.mp3";
    } else if (HomePageState.mood.compareTo("sad") == 0) {
      return "Sad.mp3";
    } else if (HomePageState.mood.compareTo("angry") == 0) {
      return "Angry.mp3";
    } else if (HomePageState.mood.compareTo("relaxed") == 0) {
      return "Relaxed.mp3";
    } else if (HomePageState.mood.compareTo("sorrow") == 0) {
      return "Sorrow.mp3";
    } else if (HomePageState.mood.compareTo("excited") == 0) {
      return "Excited.mp3";
    } else if (HomePageState.mood.compareTo("anxious") == 0) {
      return "Anxious.mp3";
    } else if (HomePageState.mood.compareTo("default") == 0) {
      return "Title_Screen.mp3";
    } else
      return "Not a valid state";
  }

  @override
  @override
  void initState() {
    super.initState();
    _loadCounter_R();
    _loadCounter_G();
    _loadCounter_B();


    loadResult();
    loadMood();
    loadPosition();
    loadUrls();
    homeAudio = GaplessAudioLoop();
    //playAudio();
    /*homeAudio.open(
      AssetsAudio(
        asset: setHomeAudio(),
        folder: "assets/audio/",
      ),
    );
    homeAudio.playOrPause();
    */
  }

  @override
  void dispose() {
    homeAudio.stop();
    super.dispose();
  }

  static playAudio() async {
    await homeAudio.loadAsset('audio/Title_Screen.mp3');
    await homeAudio.play();
  }

  static stopAudio() async {
    await homeAudio.stop();
  }

  static addIntToR() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter_R', redCount);
  }

  static addIntToG() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter_G', greenCount);
  }

  static addIntToB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter_B', blueCount);
  }

  static saveResult0() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('result0', result[0]);
  }

  static saveResult1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('result1', result[1]);
  }

  static saveResult2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('result2', result[2]);
  }

  static saveMood() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mood', mood);
  }

  static saveCatPose() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('catPose', catPose);
  }

  static saveCatPoseOutline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('catPoseOutline', catPoseOutline);
  }

  static saveCatPositionX() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('catPositionX', catPositionX);
  }

  static saveCatPositionY() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('catPositionY', catPositionY);
  }

  static saveCatYAlignment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('catYAlignment', catYAlignment);
  }

  static void update() {
    addIntToB();
    addIntToR();
    addIntToG();
    saveResult0();
    saveResult1();
    saveResult2();
    saveCatPose();
    saveCatPoseOutline();
    saveCatPositionX();
    saveCatPositionY();
    saveCatYAlignment();
    setMood();
    saveMood();
    setUrl();
    setHomeAudio();
  }

  _loadCounter_R() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      redCount = (prefs.getInt('counter_R') ?? 255);
      print(redCount);
    });
  }

  _loadCounter_G() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      greenCount = (prefs.getInt('counter_G') ?? 255);
      print(greenCount);
    });
  }

  _loadCounter_B() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      blueCount = (prefs.getInt('counter_B') ?? 255);
      print(blueCount);
    });
  }

  void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Mood Cube",
          style: TextStyle(
              color: Color.fromRGBO(
                  255 - redCount, 255 - greenCount, 255 - blueCount, 1)),
        ),
        backgroundColor: Color.fromRGBO(redCount, greenCount, blueCount, 1),
        //elevation: 0.0,

        leading: Builder(
          builder: (context) => new FlatButton(
            child:
                Image.asset('assets/images/Star.png', width: 100, height: 100),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      // elevation hides drop shadow of appbar

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              //accountName: new Text("Soyon"),
              //accountEmail: new Text(''),
              currentAccountPicture: new GestureDetector(
                child: new ClipOval(
                  child: Image.asset(catPose),
                ),
                onTap: () => print("This is your current account."),
              ),
              otherAccountsPictures: <Widget>[],
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                image: new AssetImage(catPoseOutline),
              )),
            ),
            new ListTile(
                title: new Text("Feelings"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Page1()));
                }),
            new Divider(),
            new ListTile(
                title: new Text("My Song Playlist"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Playlist.isMovie = false;
                Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Page2()));
                }),
            new Divider(),
            new ListTile(
                title: new Text("My Movie Playlist"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Playlist.isMovie = true;
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Page2()));
                }),
            new Divider(),
            new ListTile(
                title: new Text("Bluetooth Setup"),
                trailing: new Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => MainPage()));
                }),
            new Divider(),
            new ListTile(
              title: new Text("Cancel"),
              trailing: new Icon(Icons.cancel),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(redCount, greenCount, blueCount, 1),

      body: Stack(
        children: <Widget>[
          Container(
            child: new Image.asset(
              'assets/gallery/Room.png',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
              color: Color.fromRGBO(redCount, greenCount, blueCount, 0.4),
              alignment: new Alignment(-1.0, -1.0),
              //colorBlendMode: BlendMode.hardLight,
              colorBlendMode: BlendMode.softLight,
              //colorBlendMode: BlendMode.overlay,
            ),
          ),
          Positioned(
            top: -900,
            left: -30,
            child: Image.asset(
              'assets/gallery/ThoughtBubble.png',
              alignment: new Alignment(-1.0, 6.2),
              width: size.width * 1.2,
              height: size.height * 1.2,
              color: Color.fromRGBO(
                  255 - redCount, 255 - greenCount, 255 - blueCount, 11),
            ),
          ),
          Positioned(
            top: 0,
            left: 30,
            child: Image.asset('assets/gallery/Sofa_1.png',
                alignment: new Alignment(-1.0, 6.2),
                width: size.width / 2.5,
                height: size.height / 2.5),
          ),
          Positioned(
            top: catPositionX,
            left: catPositionY,
            child: Image.asset(
              catPose,
              alignment: new Alignment(3.0, catYAlignment),
              width: size.width / 3,
              height: size.height / 3,
              color: Color.fromRGBO(redCount, greenCount, blueCount, 1),
              //colorBlendMode: BlendMode.colorBurn,
            ),
          ),
          Positioned(
            top: catPositionX,
            left: catPositionY,
            child: Image.asset(
              catPoseOutline,
              alignment: new Alignment(1.0, catYAlignment),
              width: size.width / 3,
              height: size.height / 3,
              color: Color.fromRGBO(
                  255 - redCount, 255 - greenCount, 255 - blueCount, 11),
              //color: Color.fromRGBO(
              //300 - redCount, 300 - greenCount, 300 - blueCount, 1),
            ),
          ),
          Positioned(
            top: 0,
            left: 30,
            child: Image.asset('assets/gallery/Sofa_2.png',
                alignment: new Alignment(-1.0, 6.2),
                width: size.width / 2.5,
                height: size.height / 2.5),
          ),
          Positioned(
            top: 410,
            left: 225,
            child: FlatButton(
              onPressed: () {
                Playlist.isMovie = false;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Page2();
                }));
              },
              child: new Image.asset(
                "assets/gallery/Radio.png",
                alignment: new Alignment(-2.0, 1.0),
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            top: 570,
            left: 265,
            child: FlatButton(
              onPressed: () {
                Playlist.isMovie = true;

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Page2();
                }));
              },
              child: new Image.asset(
                "assets/gallery/TV.png",
                alignment: new Alignment(-2.0, 1.0),
                width: 100,
                height: 100,
              ),
            ),
          ),
          new AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: y_position1,
              curve: Curves.linear,
              left: x_position1,
              child: new FlatButton(
                  onPressed: () {
                    HomePageState.setGreen();
                    HomePageState.result[1]++;
                    print('red:');
                    print(HomePageState.redCount);
                    print('blue:');
                    print(HomePageState.blueCount);
                    setState(() {
                      HomePageState.setColor();
                    });
                    //moveCat1();
                    HomePageState.update();
                  },
                  child: new Image.asset(
                    "assets/images/Happy.png",
                    width: 100,
                    height: 100,
                  ))),
          new AnimatedPositioned(
              duration: Duration(seconds: 1),
              top: y_position2,
              curve: Curves.linear,
              left: x_position2,
              child: new FlatButton(
                  onPressed: () {
                    HomePageState.setRed();
                    HomePageState.result[0]++;
                    print('green');
                    print(HomePageState.greenCount);
                    print('blue');
                    print(HomePageState.blueCount);
                    setState(() {
                      HomePageState.setColor();
                    });
                    //moveCat2();
                    HomePageState.update();
                  },
                  child: new Image.asset(
                    "assets/images/Angry.png",
                    width: 100,
                    height: 100,
                  ))),
          new AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: y_position3,
            curve: Curves.linear,
            left: x_position3,
            child: new FlatButton(
              onPressed: () {
                HomePageState.setBlue();
                HomePageState.result[2]++;
                print('red');
                print(HomePageState.redCount);
                print('green');
                print(HomePageState.greenCount);

                setState(() {
                  HomePageState.setColor();
                });

                //moveCat3();
                HomePageState.update();
              },
              child: new Image.asset(
                "assets/images/Sad.png",
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void moveCat1() {
    setState(() {
      do {
        x_position1 = rand.nextDouble() * 260;
        y_position1 = rand.nextDouble() * 370;
      } while ((x_position1 - x_position2).abs() < 50 ||
          (x_position1 - x_position3).abs() < 50 ||
          (y_position1 - y_position2).abs() < 50 ||
          (y_position1 - y_position3).abs() < 50);
    });
  }

  void moveCat2() {
    setState(() {
      setState(() {
        do {
          x_position2 = rand.nextDouble() * 260;
          y_position2 = rand.nextDouble() * 370;
        } while ((x_position2 - x_position1).abs() < 50 ||
            (x_position2 - x_position3).abs() < 50 ||
            (y_position2 - y_position1).abs() < 50 ||
            (y_position2 - y_position3).abs() < 50);
      });
    });
  }

  void moveCat3() {
    setState(() {
      setState(() {
        do {
          x_position3 = rand.nextDouble() * 260;
          y_position3 = rand.nextDouble() * 370;
        } while ((x_position3 - x_position2).abs() < 50 ||
            (x_position3 - x_position1).abs() < 50 ||
            (y_position3 - y_position2).abs() < 50 ||
            (y_position3 - y_position1).abs() < 50);
      });
    });
  }
}
