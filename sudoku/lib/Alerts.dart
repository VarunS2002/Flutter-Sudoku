import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sudoku/Styles.dart';

class AlertGameOver extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.bg_2,
      title: Text(
        'Game Over',
        style: TextStyle(color: Styles.fg),
      ),
      content: Text(
        'You successfully solved the Sudoku',
        style: TextStyle(color: Styles.fg),
      ),
      actions: [
        FlatButton(
          textColor: Styles.primaryColor,
          onPressed: () {
            Navigator.pop(context);
            restartGame = true;
          },
          child: Text('Restart Game'),
        ),
        FlatButton(
          textColor: Styles.primaryColor,
          onPressed: () {
            Navigator.pop(context);
            newGame = true;
          },
          child: Text('New Game'),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AlertDifficultyState extends StatefulWidget {
  String currentDifficultyLevel;

  AlertDifficultyState(String currentDifficultyLevel) {
    this.currentDifficultyLevel = currentDifficultyLevel;
  }

  @override
  AlertDifficulty createState() => AlertDifficulty(this.currentDifficultyLevel);

  static get difficulty {
    return AlertDifficulty.difficulty;
  }

  static set difficulty(String level) {
    AlertDifficulty.difficulty = level;
  }
}

class AlertDifficulty extends State<AlertDifficultyState> {
  static String difficulty;
  static final List<String> difficulties = [
    'beginner',
    'easy',
    'medium',
    'hard'
  ];
  String currentDifficultyLevel;

  AlertDifficulty(String currentDifficultyLevel) {
    this.currentDifficultyLevel = currentDifficultyLevel;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
        'Select Difficulty Level',
        style: TextStyle(color: Styles.fg),
      )),
      backgroundColor: Styles.bg_2,
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String level in difficulties)
          SimpleDialogOption(
            onPressed: () {
              if (level != this.currentDifficultyLevel) {
                setState(() {
                  difficulty = level;
                });
              }
              Navigator.pop(context);
            },
            child: Text(level[0].toUpperCase() + level.substring(1),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: level == this.currentDifficultyLevel
                        ? Styles.primaryColor
                        : Styles.fg)),
          ),
      ],
    );
  }
}

class AlertExit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.bg_2,
      title: Text(
        'Exit Game',
        style: TextStyle(color: Styles.fg),
      ),
      content: Text(
        'Are you sure you want to exit the game ?',
        style: TextStyle(color: Styles.fg),
      ),
      actions: [
        FlatButton(
          textColor: Styles.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        FlatButton(
          textColor: Styles.primaryColor,
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}

class AlertNumbersState extends StatefulWidget {
  @override
  AlertNumbers createState() => AlertNumbers();

  static get number {
    return AlertNumbers.number;
  }

  static set number(int number) {
    AlertNumbers.number = number;
  }
}

class AlertNumbers extends State<AlertNumbersState> {
  static int number;
  int numberSelected;
  static final List<int> numberList1 = [1, 2, 3];
  static final List<int> numberList2 = [4, 5, 6];
  static final List<int> numberList3 = [7, 8, 9];

  List<SizedBox> createButtons(List<int> numberList) {
    return <SizedBox>[
      for (int numbers in numberList)
        SizedBox(
          width: 38,
          height: 38,
          child: FlatButton(
            onPressed: () => {
              setState(() {
                numberSelected = numbers;
                number = numberSelected;
                Navigator.pop(context);
              })
            },
            color: Styles.bg_2,
            textColor: Styles.primaryColor,
            highlightColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Styles.fg,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              numbers.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        )
    ];
  }

  Row oneRow(List<int> numberList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: createButtons(numberList),
    );
  }

  List<Row> createRows() {
    List<List> numberLists = [numberList1, numberList2, numberList3];
    List<Row> rowList = new List<Row>.filled(3, null);
    for (var i = 0; i <= 2; i++) {
      rowList[i] = oneRow(numberLists[i]);
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Styles.bg_2,
        title: Center(
            child: Text(
          'Choose a Number',
          style: TextStyle(color: Styles.fg),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createRows(),
        ));
  }
}

class AlertAbout extends StatelessWidget {
  static const String authorUrl = "https://www.github.com/VarunS2002/";
  static const String sourceUrl =
      "https://github.com/VarunS2002/Flutter-Sudoku/";
  static const String licenseUrl =
      "https://github.com/VarunS2002/Flutter-Sudoku/blob/master/LICENSE";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Styles.bg_2,
      title: Center(
        child: Text(
          'About',
          style: TextStyle(color: Styles.fg),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon/icon_round.png',
                  height: 48.0, width: 48.0, fit: BoxFit.contain),
              Text(
                '   Sudoku',
                style: TextStyle(
                    color: Styles.fg,
                    fontFamily: 'roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'com.varuns2002.sudoku',
                style: TextStyle(
                    color: Styles.fg,
                    fontFamily: 'roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Version: v2.0.1 b1000',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Author: ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
              RichText(
                  text: TextSpan(
                      text: 'VarunS2002',
                      style: TextStyle(
                          color: Styles.primaryColor,
                          fontFamily: 'roboto',
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(AlertAbout.authorUrl)) {
                            await launch(AlertAbout.authorUrl);
                          } else {
                            throw 'Could not launch ${AlertAbout.authorUrl}';
                          }
                        })),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'License: ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
              RichText(
                  text: TextSpan(
                      text: 'GNU GPLv3',
                      style: TextStyle(
                          color: Styles.primaryColor,
                          fontFamily: 'roboto',
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(AlertAbout.licenseUrl)) {
                            await launch(AlertAbout.licenseUrl);
                          } else {
                            throw 'Could not launch ${AlertAbout.licenseUrl}';
                          }
                        })),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '                ',
                style: TextStyle(
                    color: Styles.fg, fontFamily: 'roboto', fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      text: 'Source Code',
                      style: TextStyle(
                          color: Styles.primaryColor,
                          fontFamily: 'roboto',
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(AlertAbout.sourceUrl)) {
                            await launch(AlertAbout.sourceUrl);
                          } else {
                            throw 'Could not launch ${AlertAbout.sourceUrl}';
                          }
                        })),
            ],
          ),
        ],
      ),
    );
  }
}
