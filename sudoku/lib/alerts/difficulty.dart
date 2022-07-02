import 'package:flutter/material.dart';

import '../styles.dart';

// ignore: must_be_immutable
class AlertDifficultyState extends StatefulWidget {
  String currentDifficultyLevel;

  AlertDifficultyState(this.currentDifficultyLevel, {Key? key})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  AlertDifficulty createState() => AlertDifficulty(currentDifficultyLevel);

  static String? get difficulty {
    return AlertDifficulty.difficulty;
  }

  static set difficulty(String? level) {
    AlertDifficulty.difficulty = level;
  }
}

class AlertDifficulty extends State<AlertDifficultyState> {
  // ignore: avoid_init_to_null
  static String? difficulty = null;
  static final List<String> difficulties = [
    'beginner',
    'easy',
    'medium',
    'hard'
  ];
  String currentDifficultyLevel;

  AlertDifficulty(this.currentDifficultyLevel);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Center(
          child: Text(
        'Select Difficulty Level',
        style: TextStyle(color: Styles.foregroundColor),
      )),
      backgroundColor: Styles.secondaryBackgroundColor,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      children: <Widget>[
        for (String level in difficulties)
          SimpleDialogOption(
            onPressed: () {
              if (level != currentDifficultyLevel) {
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
                    color: level == currentDifficultyLevel
                        ? Styles.primaryColor
                        : Styles.foregroundColor)),
          ),
      ],
    );
  }
}
