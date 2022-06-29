import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Styles.dart';
import 'main.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: new Text(
        '\nSudoku',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Styles.foregroundColor),
      ),
      image: new Image.asset('assets/icon/icon_foreground.png'),
      photoSize: 50,
      backgroundColor: Styles.primaryBackgroundColor,
      useLoader: true,
      loaderColor: Styles.primaryColor,
      loadingText: Text(
        'VarunS2002',
        style: TextStyle(color: Colors.grey),
      ),
      loadingTextPadding: const EdgeInsets.only(top: 10.0),
      styleTextUnderTheLoader: const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
