<img width="128" height="128" src="https://raw.githubusercontent.com/VarunS2002/Flutter-Sudoku/master/sudoku/assets/icon/icon_round.png" alt="icon_square">

# Flutter-Sudoku

## [Play Online](https://sudoku-vs2002.web.app/)

## [Downloads](https://github.com/VarunS2002/Flutter-Sudoku/releases)

> [![APK: v2.4.0](https://img.shields.io/badge/APK-v2.4.0-brightgreen)](https://github.com/VarunS2002/Flutter-Sudoku/releases/download/2.4.0/Sudoku_2.4.0.apk)
[![EXE: v2.4.0](https://img.shields.io/badge/EXE-v2.4.0-brightgreen)](https://github.com/VarunS2002/Flutter-Sudoku/releases/download/2.4.0/Sudoku_2.4.0.exe)
[![Web: v2.4.0](https://img.shields.io/badge/Web-v2.4.0-brightgreen)](https://sudoku-vs2002.web.app/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This is a fully fledged Sudoku game written in Dart using Flutter.

It can be exported to Android, iOS, Fuchsia, Windows, Linux, MacOS, PWA or a Web App.

## Installation & Usage:

- Can be played online in the browser. See [Play Online](#play-online)

- Can be installed as a Progressive Web App on any platform.
  See [Use Progressive Web Apps](https://support.google.com/chrome/answer/9658361?co=GENIE.Platform%3DAndroid&hl=en)

- Can be installed as an Android app. See [Downloads](https://github.com/VarunS2002/Flutter-Sudoku/releases)

## Building:

### Requirements:

- [Flutter](https://flutter.dev/docs/get-started/install)

- For Exporting to Android:

    - [Android Studio](https://developer.android.com/studio#downloads) 3.0+
      / [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) 2017.1+
      with [Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter)
      and [Dart Plugin](https://plugins.jetbrains.com/plugin/6351-dart) (recommeded)

    - Android SDK from Android Studio or IntelliJ IDEA (API Level 30 recommended)

    - [Java SE JDK](https://www.oracle.com/in/java/technologies/javase-downloads.html) (v8 recommended)

    - [Gradle](https://gradle.org/releases/)

    - Set ANDROID_HOME and ANDROID_SDK_ROOT variables

    - Add JDK to PATH

- For Exporting to Web:

    - Set current working directory to sudoku

    - Run these commands:
      ```
       flutter config --enable-web
      ```

- For Exporting to Windows:

    - Set current working directory to sudoku

    - Run these commands:
      ```
       flutter config --enable-windows-desktop
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

- This will install all the required packages

4. Run `flutter doctor` to check fo any issues (Optional)

> #### Steps for exporting to a PWA or Web App

1. Set current working directory to sudoku

2. Run `flutter build web --release`

- This will compile the program and store the files in the `sudoku/build/web` directory

- You can run a simple http server in this directory to run your app in the browser

- [dhttpd](https://pub.dev/packages/dhttpd) is a Dart package for running a simple http server

> #### Steps for exporting to Windows

1. Set current working directory to sudoku

2. Run `flutter build windows --release`

- This will compile the program and store the files in the `sudoku/build/windows/runner/Release` directory

- It will export a release build that can be run directly

> #### Steps for exporting to Android

1. Set current working directory to sudoku

2. To export as an Android app run:

   `flutter build apk` to build a fat APK for all ABIs

   OR

   `flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi` to build multiple APKs
   for every ABI

- This will export a release build of the apk file signed with debug keys which can be installed on an Android phone or
  emulator

- The APK file/s will be saved in `sudoku/build/app/outputs/flutter-apk`

- Minimum Android Version Required : Android 4.1.x Jellybean (API Level 16)

## Features:

- Generates a New Game when you start the app

- Clicking a box displays a dialog with buttons 1-9 to input in the box

- Clickable buttons will initially have no number and will turn red after the first click

- Long pressing a button will erase your input

- After completely solving the grid, if the solution is correct it will alert you that you successfully solved the
  Sudoku

- The numbers in all the clickable buttons will turn blue if the solution is correct (This will also happen if you click
  Show Solution)

- 4 different difficulty levels to choose from :
    - Beginner - 18 empty squares
    - Easy - 27 empty squares
    - Medium - 36 empty squares
    - Hard - 54 empty squares

- New Game

- Restart Game

- Show Solution

- Dark and Light theme

- Various Accent Colors to choose from

- Material Design

## Note:

- Dependencies:
    - [sudoku_solver_generator](https://pub.dev/packages/sudoku_solver_generator) is used for the Sudoku logic

    - [flutter_animated_dialog](https://pub.dev/packages/flutter_animated_dialog) is used for animated alert dialogs

    - [shared_preferences](https://pub.dev/packages/shared_preferences) is used for saving preferences locally

    - [splashscreen](https://pub.dev/packages/splashscreen) is used for the splashscreen

    - [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) is used for generating the native
      splashscreen files

    - [url_launcher](https://pub.dev/packages/url_launcher) is used for opening hyperlinks

    - [bitsdojo_window](https://pub.dev/packages/bitsdojo_window) is used for title bar improvements on desktop

- [NSIS](https://nsis.sourceforge.io/) is used for building the Windows installer

- Untested on iOS, MacOS, Linux and Fuchsia. Additional changes might be required to work correctly

- If you face any issue or have suggestions then feel free to open an issue on GitHub

## Screenshots:

- Main Screen while solved with dark theme:<br><br>

  ![Solved_Dark](https://i.imgur.com/PItmR0H.png)
  <br><br>

- Main Screen while solving with light theme:<br><br>

  ![Solving_Light](https://i.imgur.com/l987sBq.png)
  <br><br>

- Choose Number Alert:<br><br>

  ![Choose](https://i.imgur.com/k8IQA7E.png)
  <br><br>

- Game Over Alert Box:<br><br>

  ![Result](https://i.imgur.com/tun5TaS.png)
  <br><br>

- Options:<br><br>

  ![Options](https://i.imgur.com/MA0E2Ey.png)
  <br><br>

- Windows with Violet Accent Color:<br><br>

  ![Windows_Violet](https://i.imgur.com/nxIZDSV.png)
  <br><br>
