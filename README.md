<img width="128" height="128" src="https://raw.githubusercontent.com/VarunS2002/Flutter-Sudoku/master/sudoku/assets/icon/icon_round.png" alt="icon_square">

# Flutter-Sudoku

<!--
## Play Online:

>### [Firebase]()
>
>### [GitHub Pages](https://varuns2002.github.io/Flutter-Sudoku/)
-->

## [Downloads](https://github.com/VarunS2002/Flutter-Sudoku/releases)
>[![APK: v1.0.0](https://img.shields.io/badge/APK-v1.0.0-brightgreen)](https://github.com/VarunS2002/Flutter-Sudoku/releases/download/1.0.0/Sudoku_1.0.0.apk)
![Build: passing](https://img.shields.io/badge/build-passing-brightgreen)
>[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This is a fully fledged Sudoku game written in Dart using Flutter.

It can be exported to Android, iOS, Fuchsia, Windows, MacOS, PWA or a Web App.

## Installation & Usage:
<!--
- Can be played online in the browser. See [Play Online](#play-online)

- Can be installed as a Progressive Web App on any platform. See [Use Progressive Web Apps](https://support.google.com/chrome/answer/9658361?co=GENIE.Platform%3DAndroid&hl=en)
-->
- Can be installed as an Android app. See [Downloads](https://github.com/VarunS2002/Flutter-Sudoku/releases)

## Building:

### Requirements:

- [Flutter](https://flutter.dev/docs/get-started/install)

- For Exporting to Android:

    - Android Studio/IntelliJ IDEA with Flutter Plugin (recommeded)

    - Android SDK (30 recommended)

    - Java SE JDK (8 recommended)

    - Gradle

    - Set ANDROID_HOME and ANDROID_SDK_ROOT variables

    - Add JDK to PATH

- For Exporting to Web:

    - Set current working directory to sudoku

    - Run these commands:
      ```
       flutter channel beta
       flutter upgrade
       flutter config --enable-web
      ```

### Installing required packages

1. Clone this repository

2. Set current working directory to sudoku

3. Run these commands:
   ```
   flutter pub get
   flutter pub upgrade
   flutter pub outdated
   ```
-  This will install all the required packages

4. Run `flutter doctor` to check fo any issues (Optional)

>#### Steps for exporting to a PWA or Web App

1. Set current working directory to sudoku

2. Run `flutter build web`

- This will compile the program and store the files in the `sudoku/build/web` directory

- You can run a simple http server in this directory to run your app in the browser

- [dhttpd](https://pub.dev/packages/dhttpd) is a Dart package for running a simple http server

>#### Steps for exporting to Android

1. Set current working directory to sudoku

2. To export as an Android app run:

   `flutter build apk` to build a fat APK for all ABIs

   OR

   `flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi` to build multiple APKs for every ABI

- This will export a release build of the apk file signed with debug keys which can be installed on an Android phone or emulator

- The APK file/s will be saved in `sudoku/build/app/outputs/flutter-apk`

- Minimum Android Version Required : Android 4.1.x Jellybean (API Level 16)

## Features:

- Uses a combination of Sudoku generation and solving algorithm to create a unique game

- Generates a New Game when you start the app

- Input numbers in the grid by repeatedly clicking a box

- Clickable buttons will initially have no number and will turn red after the first click

- After completely solving the grid, if the solution is correct it will alert you that you successfully solved the Sudoku

- The numbers in all the clickable buttons will turn blue if the solution is correct (This will also happen if you click Show Solution)

- Button to start a New Game

- Button to Restart Game

- Button to Show the Solution

- Material Design

## Note:

- [flutter_speed_dial_material_design](https://pub.dev/packages/flutter_speed_dial_material_design) is used for Stacked Floating Action Buttons
  
- If you face any issue then feel free to open an issue on GitHub

## Screenshots:

- Main Screen while solving:<br><br>

  ![Light](https://i.imgur.com/UeP0L0B.jpg)
  <br><br>

- Main Screen while solved:<br><br>

  ![Solved](https://i.imgur.com/MXbxBQ7.jpg)
  <br><br>

- Options:<br><br>

  ![Options](https://i.imgur.com/wutzT0p.jpg)
  <br><br>

- Game Over Alert Box:<br><br>

  ![Result](https://i.imgur.com/afe5lAK.jpg)
