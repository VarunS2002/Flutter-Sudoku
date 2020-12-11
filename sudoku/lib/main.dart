import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'Sudoku.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static MaterialColor primaryColor = MaterialColor(4281893119, {
    50: Color(0xff92b9ff),
    100: Color(0xff88b3ff),
    200: Color(0xff74a6ff),
    300: Color(0xff6099ff),
    400: Color(0xff4c8dff),
    500: Color(0xff3880ff),
    600: Color(0xff3273e5),
    700: Color(0xff2d66cc),
    800: Color(0xff275ab2),
    900: Color(0xff224d99)
  });
  static MaterialColor secondaryColor = MaterialColor(4293608538, {
    50: Color(0xfff498a4),
    100: Color(0xfff38f9c),
    200: Color(0xfff17c8c),
    300: Color(0xffef697b),
    400: Color(0xffed576a),
    500: Color(0xffeb445a),
    600: Color(0xffd33d51),
    700: Color(0xffbc3648),
    800: Color(0xffa4303f),
    900: Color(0xff8d2936)
  });

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    print(color.value);
    print(swatch);
    return MaterialColor(color.value, swatch);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: primaryColor,
      ),
      home: MyHomePage(title: 'Sudoku'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool firstRun = true;
  bool gameOver = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  List<List<List<int>>> gameList;
  List<List<int>> game;
  List<List<int>> gameCopy;
  List<List<int>> gameSolved;

  void checkResult() {
    if (game.toString() == gameSolved.toString()) {
      isButtonDisabled = !isButtonDisabled;
      gameOver = true;
      Timer(Duration(milliseconds: 500), () {
        alertGameOver();
      });
    }
  }

  Future<bool> alertExit() async {
    return (await showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ClassicGeneralDialogWidget(
              titleText: 'Exit Game',
              contentText: 'Are you sure you want to exit the game ?',
              positiveText: 'No',
              positiveTextStyle: TextStyle(color: MyApp.primaryColor),
              onPositiveClick: () {
                Navigator.of(context).pop(false);
              },
              negativeText: 'Yes',
              negativeTextStyle: TextStyle(color: MyApp.primaryColor),
              onNegativeClick: () {
                Navigator.of(context).pop(true);
              },
            );
          },
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 250),
        )) ??
        false;
  }

  Future<bool> alertGameOver() async {
    return (await showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ClassicGeneralDialogWidget(
              titleText: 'Game Over',
              contentText: 'You successfully solved the Sudoku',
              positiveText: 'Ok',
              positiveTextStyle: TextStyle(color: MyApp.primaryColor),
              onPositiveClick: () {
                Navigator.of(context).pop(false);
              },
              negativeText: 'New Game',
              negativeTextStyle: TextStyle(color: MyApp.primaryColor),
              onNegativeClick: () {
                Navigator.of(context).pop(true);
                newGame();
              },
            );
          },
          animationType: DialogTransitionType.sizeFade,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 250),
        )) ??
        false;
  }

  // ignore: missing_return
  static List<List<List<int>>> getNewGame([String difficulty = 'easy']) {
    Sudoku object = new Sudoku(difficulty);
    return [object.newSudoku, object.newSudokuSolved];
  }

  void setGame([String difficulty = 'easy']) {
    gameList = getNewGame(difficulty);
    game = gameList[0];
    gameCopy = Sudoku.copyGrid(game);
    gameSolved = gameList[1];
  }

  void showSolution() {
    setState(() {
      game = Sudoku.copyGrid(gameSolved);
      isButtonDisabled =
          !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = true;
    });
  }

  void newGame() {
    setState(() {
      setGame('easy');
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  void restartGame() {
    setState(() {
      game = Sudoku.copyGrid(gameCopy);
      isButtonDisabled =
          isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = false;
    });
  }

  Color buttonColor(int k, int i) {
    Color color;
    if ([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) {
      color = Colors.grey[300];
    } else if ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) {
      color = Colors.grey[300];
    } else if ([6, 7, 8].contains(k) && [3, 4, 5].contains(i)) {
      color = Colors.grey[300];
    } else {
      color = Colors.white;
    }
    return color;
  }

  List<SizedBox> createButtons() {
    if (firstRun) {
      setGame('easy');
      firstRun = false;
    }
    MaterialColor emptyColor;
    if (gameOver) {
      emptyColor = MyApp.primaryColor;
    } else {
      emptyColor = MyApp.secondaryColor;
    }
    List<SizedBox> buttonList = new List<SizedBox>(9);
    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        width: 38,
        height: 38,
        child: FlatButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i]),
          color: buttonColor(k, i),
          textColor: game[k][i] == 0 ? buttonColor(k, i) : MyApp.secondaryColor,
          disabledColor: buttonColor(k, i),
          disabledTextColor: gameCopy[k][i] == 0 ? emptyColor : Colors.black,
          highlightColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 0.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(0)),
          child: Text(game[k][i] != 0 ? game[k][i].toString() : ' '),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  Row oneRow() {
    return Row(
      children: createButtons(),
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<Row> createRows() {
    List<Row> rowList = new List<Row>(9);
    for (var i = 0; i <= 8; i++) {
      rowList[i] = oneRow();
    }
    return rowList;
  }

  void callback(List<int> index) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      game[index[0]][index[1]] = (game[index[0]][index[1]] % 9) + 1;
      checkResult();
    });
  }

  SpeedDialController speedDialController = SpeedDialController();

  Widget buildFloatingActionButton() {
    final TextStyle customStyle =
        TextStyle(inherit: false, color: Colors.black);
    final icons = [
      SpeedDialAction(
          child: Icon(Icons.refresh),
          label: Text('Restart Game', style: customStyle)),
      SpeedDialAction(
          child: Icon(Icons.add_rounded),
          label: Text('New Game', style: customStyle)),
      SpeedDialAction(
          child: Icon(Icons.lightbulb_outline_rounded),
          label: Text('Show Solution', style: customStyle)),
    ];

    return SpeedDialFloatingActionButton(
      actions: icons,
      childOnFold: Icon(Icons.menu_rounded, key: UniqueKey()),
      screenColor: Colors.black.withOpacity(0.3),
      childOnUnfold: Icon(Icons.close_rounded, key: UniqueKey()),
      useRotateAnimation: false,
      onAction: onSpeedDialAction,
      controller: speedDialController,
      isDismissible: true,
      backgroundColor: Colors.white,
      foregroundColor: MyApp.primaryColor,
    );
  }

  onSpeedDialAction(int selectedActionIndex) {
    switch (selectedActionIndex) {
      case 0:
        {
          speedDialController.unfold();
          Timer(Duration(milliseconds: 300), () {
            restartGame();
          });
        }
        break;
      case 1:
        {
          speedDialController.unfold();
          Timer(Duration(milliseconds: 300), () {
            newGame();
          });
        }
        break;
      case 2:
        {
          speedDialController.unfold();
          Timer(Duration(milliseconds: 300), () {
            showSolution();
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new WillPopScope(
        onWillPop: alertExit,
        child: new Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,

              children: createRows(),
            ),
          ),
          floatingActionButton: buildFloatingActionButton(),
        ));
  }
}
