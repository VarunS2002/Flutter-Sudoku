import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles.dart';

class AlertNumbersState extends StatefulWidget {
  const AlertNumbersState({Key? key}) : super(key: key);

  @override
  AlertNumbers createState() => AlertNumbers();

  static int? get number {
    return AlertNumbers.number;
  }

  static set number(int? number) {
    AlertNumbers.number = number;
  }
}

class AlertNumbers extends State<AlertNumbersState> {
  // ignore: avoid_init_to_null
  static int? number = null;
  late int numberSelected;
  static final List<int> numberList1 = [1, 2, 3];
  static final List<int> numberList2 = [4, 5, 6];
  static final List<int> numberList3 = [7, 8, 9];

  void select(int numSelected) {
    setState(() {
      numberSelected = number = numSelected;
      Navigator.pop(context);
    });
  }

  List<SizedBox> createButtons(List<int> numberList) {
    return <SizedBox>[
      for (int numbers in numberList)
        SizedBox(
          width: 38,
          height: 38,
          child: TextButton(
            onPressed: () => select(numbers),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Styles.secondaryBackgroundColor),
              foregroundColor:
                  MaterialStateProperty.all<Color>(Styles.primaryColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                color: Styles.foregroundColor,
                width: 1,
                style: BorderStyle.solid,
              )),
            ),
            child: Text(
              numbers.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
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
    List<List<int>> numberLists = [numberList1, numberList2, numberList3];
    List<Row> rowList = <Row>[];
    for (var i = 0; i <= 2; i++) {
      rowList.add(oneRow(numberLists[i]));
    }
    return rowList;
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(
        onKey: (_, __) => KeyEventResult.handled
      ),
      autofocus: true,
      onKey: (ev) {
        if (!(ev is RawKeyUpEvent)) return;
        var key = ev.logicalKey;
        if (key == LogicalKeyboardKey.escape) Navigator.pop(context);
        else if (key == LogicalKeyboardKey.digit1) select(1);
        else if (key == LogicalKeyboardKey.digit2) select(2);
        else if (key == LogicalKeyboardKey.digit3) select(3);
        else if (key == LogicalKeyboardKey.digit4) select(4);
        else if (key == LogicalKeyboardKey.digit5) select(5);
        else if (key == LogicalKeyboardKey.digit6) select(6);
        else if (key == LogicalKeyboardKey.digit7) select(7);
        else if (key == LogicalKeyboardKey.digit8) select(8);
        else if (key == LogicalKeyboardKey.digit9) select(9);
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Styles.secondaryBackgroundColor,
        title: Center(
            child: Text(
          'Choose a Number',
          style: TextStyle(color: Styles.foregroundColor),
        )),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: createRows(),
        )));
  }
}
