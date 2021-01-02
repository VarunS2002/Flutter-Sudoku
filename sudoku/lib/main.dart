import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:sudoku/Styles.dart';
import 'package:sudoku/Alerts.dart';
import 'package:sudoku/Sudoku.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        primarySwatch: Styles.primaryColor,
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
  bool isFABDisabled = false;
  List<List<List<int>>> gameList;
  List<List<int>> game;
  List<List<int>> gameCopy;
  List<List<int>> gameSolved;
  static String currentDifficultyLevel;
  static String currentTheme;

  @override
  void initState() {
    super.initState();
    getPrefs().whenComplete(() {
      if (currentDifficultyLevel == null) {
        currentDifficultyLevel = 'easy';
        setPrefs('currentDifficultyLevel');
      }
      if (currentTheme == null) {
        currentTheme = 'dark';
        setPrefs('currentTheme');
      }
      newGame(currentDifficultyLevel);
      changeTheme('set');
    });
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentDifficultyLevel = prefs.getString('currentDifficultyLevel');
      currentTheme = prefs.getString('currentTheme');
    });
  }

  setPrefs(String property) async {
    final prefs = await SharedPreferences.getInstance();
    if (property == 'currentDifficultyLevel') {
      prefs.setString('currentDifficultyLevel', currentDifficultyLevel);
    } else if (property == 'currentTheme') {
      prefs.setString('currentTheme', currentTheme);
    }
  }

  void changeTheme(String mode) {
    setState(() {
      if (currentTheme == 'light') {
        if (mode == 'switch') {
          Styles.bg = Styles.dark;
          Styles.bg_2 = Styles.grey;
          Styles.fg = Styles.light;
          currentTheme = 'dark';
        } else if (mode == 'set') {
          Styles.bg = Styles.light;
          Styles.bg_2 = Styles.light;
          Styles.fg = Styles.dark;
        }
      } else if (currentTheme == 'dark') {
        if (mode == 'switch') {
          Styles.bg = Styles.light;
          Styles.bg_2 = Styles.light;
          Styles.fg = Styles.dark;
          currentTheme = 'light';
        } else if (mode == 'set') {
          Styles.bg = Styles.dark;
          Styles.bg_2 = Styles.grey;
          Styles.fg = Styles.light;
        }
      }
      setPrefs('currentTheme');
      isFABDisabled = true;
    });
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        isFABDisabled = false;
      });
    });
  }

  void checkResult() {
    if (game.toString() == gameSolved.toString()) {
      isButtonDisabled = !isButtonDisabled;
      gameOver = true;
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          isFABDisabled = true;
        });
        showAnimatedDialog<void>(
            animationType: DialogTransitionType.fadeScale,
            barrierDismissible: true,
            duration: Duration(milliseconds: 350),
            context: context,
            builder: (_) => AlertGameOver()).whenComplete(() {
          if (AlertGameOver.newGame) {
            newGame();
            AlertGameOver.newGame = false;
          } else if (AlertGameOver.restartGame) {
            restartGame();
            AlertGameOver.restartGame = false;
          }
          setState(() {
            isFABDisabled = false;
          });
        });
      });
    }
  }

  static List<List<List<int>>> getNewGame([String difficulty = 'easy']) {
    Sudoku object = new Sudoku(difficulty);
    return [object.newSudoku, object.newSudokuSolved];
  }

  void setGame(int mode, [String difficulty = 'easy']) {
    if (mode == 1) {
      game = new List.generate(9, (i) => [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = Sudoku.copyGrid(game);
      gameSolved = Sudoku.copyGrid(game);
    } else {
      gameList = getNewGame(difficulty);
      game = gameList[0];
      gameCopy = Sudoku.copyGrid(game);
      gameSolved = gameList[1];
    }
  }

  void showSolution() {
    setState(() {
      game = Sudoku.copyGrid(gameSolved);
      isButtonDisabled =
          !isButtonDisabled ? !isButtonDisabled : isButtonDisabled;
      gameOver = true;
    });
  }

  void newGame([String difficulty = 'easy']) {
    setState(() {
      setGame(2, difficulty);
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
    if (([0, 1, 2].contains(k) && [3, 4, 5].contains(i)) ||
        ([3, 4, 5].contains(k) && [0, 1, 2, 6, 7, 8].contains(i)) ||
        ([6, 7, 8].contains(k) && [3, 4, 5].contains(i))) {
      if (Styles.bg == Styles.dark) {
        color = Styles.grey;
      } else {
        color = Colors.grey[300];
      }
    } else {
      color = Styles.bg;
    }

    return color;
  }

  List<SizedBox> createButtons() {
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }
    MaterialColor emptyColor;
    if (gameOver) {
      emptyColor = Styles.primaryColor;
    } else {
      emptyColor = Styles.secondaryColor;
    }
    List<SizedBox> buttonList = new List<SizedBox>.filled(9, null);
    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        width: 38,
        height: 38,
        child: FlatButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () {
                  setState(() {
                    isFABDisabled = true;
                  });
                  showAnimatedDialog<void>(
                      animationType: DialogTransitionType.fade,
                      barrierDismissible: true,
                      duration: Duration(milliseconds: 300),
                      context: context,
                      builder: (_) => AlertNumbersState()).whenComplete(() {
                    callback([k, i], AlertNumbersState.number);
                    AlertNumbersState.number = null;
                    setState(() {
                      isFABDisabled = false;
                    });
                  });
                },
          color: buttonColor(k, i),
          textColor:
              game[k][i] == 0 ? buttonColor(k, i) : Styles.secondaryColor,
          disabledColor: buttonColor(k, i),
          disabledTextColor: gameCopy[k][i] == 0 ? emptyColor : Styles.fg,
          highlightColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Styles.fg,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(0)),
          child: Text(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
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
    List<Row> rowList = new List<Row>.filled(9, null);
    for (var i = 0; i <= 8; i++) {
      rowList[i] = oneRow();
    }
    return rowList;
  }

  void callback(List<int> index, int number) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (number == null) {
        return;
      }
      game[index[0]][index[1]] = number;
      checkResult();
    });
  }

  SpeedDialController speedDialController = SpeedDialController();

  Widget buildFloatingActionButton() {
    final TextStyle customStyle = TextStyle(
        inherit: false,
        //color: Styles.fg
        color: Colors.black);
    final icons = [
      SpeedDialAction(
          backgroundColor: Styles.bg_2,
          child: Icon(Icons.refresh),
          label: Text('Restart Game', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Styles.bg_2,
          child: Icon(Icons.add_rounded),
          label: Text('New Game', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Styles.bg_2,
          child: Icon(Icons.lightbulb_outline_rounded),
          label: Text('Show Solution', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Styles.bg_2,
          child: Icon(Icons.build_outlined),
          label: Text('Set Difficulty', style: customStyle)),
      SpeedDialAction(
          backgroundColor: Styles.bg_2,
          child: Icon(Icons.invert_colors_on_rounded),
          label: Text('Switch Theme', style: customStyle)),
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
      backgroundColor: Styles.primaryColor,
      foregroundColor: Styles.bg,
      //labelBackgroundColor: Styles.bg_2,
      //labelShadowColor: Colors.grey.withOpacity(0.1),
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
            newGame(currentDifficultyLevel);
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
      case 3:
        {
          speedDialController.unfold();
          Timer(Duration(milliseconds: 300), () {
            setState(() {
              isFABDisabled = true;
            });
            showAnimatedDialog<void>(
                    animationType: DialogTransitionType.fadeScale,
                    barrierDismissible: true,
                    duration: Duration(milliseconds: 350),
                    context: context,
                    builder: (_) =>
                        AlertDifficultyState(currentDifficultyLevel))
                .whenComplete(() {
              if (AlertDifficultyState.difficulty != null) {
                Timer(Duration(milliseconds: 300), () {
                  newGame(AlertDifficultyState.difficulty);
                  currentDifficultyLevel = AlertDifficultyState.difficulty;
                  AlertDifficultyState.difficulty = null;
                  setPrefs('currentDifficultyLevel');
                });
              }
              setState(() {
                isFABDisabled = false;
              });
            });
          });
        }
        break;
      case 4:
        {
          speedDialController.unfold();
          Timer(Duration(milliseconds: 300), () {
            changeTheme('switch');
            setPrefs('currentTheme');
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
        onWillPop: () async {
          if (kIsWeb) {
            return false;
          } else {
            setState(() {
              isFABDisabled = true;
            });
            showAnimatedDialog<void>(
                animationType: DialogTransitionType.fadeScale,
                barrierDismissible: true,
                duration: Duration(milliseconds: 350),
                context: context,
                builder: (_) => AlertExit()).whenComplete(() {
              setState(() {
                isFABDisabled = false;
              });
            });
          }
          return true;
        },
        child: new Scaffold(
          backgroundColor: Styles.bg,
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
          floatingActionButton: !isFABDisabled
              ? buildFloatingActionButton()
              : FloatingActionButton(
                  onPressed: null,
                  child: Icon(Icons.menu_rounded),
                  foregroundColor: Styles.bg,
                  backgroundColor: Styles.primaryColor,
                ),
        ));
  }
}
