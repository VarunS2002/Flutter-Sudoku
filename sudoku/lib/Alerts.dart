import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class AlertGameOver extends StatelessWidget {
  static bool newGame = false;
  static bool restartGame = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text('Game Over'),
      content: Text('You successfully solved the Sudoku'),
      actions: [
        FlatButton(
          textColor: MyApp.primaryColor,
          onPressed: () {
            Navigator.pop(context);
            restartGame = true;
          },
          child: Text('Restart Game'),
        ),
        FlatButton(
          textColor: MyApp.primaryColor,
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
      title: Center(child: Text('Select Difficulty Level')),
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
                        ? MyApp.primaryColor
                        : Colors.black)),
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
      title: Text('Exit Game'),
      content: Text('Are you sure you want to exit the game ?'),
      actions: [
        FlatButton(
          textColor: MyApp.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('No'),
        ),
        FlatButton(
          textColor: MyApp.primaryColor,
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
            color: Colors.white,
            textColor: MyApp.primaryColor,
            highlightColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black,
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
    List<Row> rowList = new List<Row>(3);
    for (var i = 0; i <= 2; i++) {
      rowList[i] = oneRow(numberLists[i]);
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text('Choose a Number')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createRows(),
        ));
  }
}
