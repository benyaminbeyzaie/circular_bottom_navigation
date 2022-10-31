# Circular Bottom Navigation (or maybe a tab bar).

<a href="https://github.com/Solido/awesome-flutter">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>

[![pub package](https://img.shields.io/pub/v/circular_bottom_navigation.svg)](https://pub.dartlang.org/packages/circular_bottom_navigation)
[![APK](https://img.shields.io/badge/APK-Demo-brightgreen.svg)](https://github.com/benyaminbeyzaie/circular_bottom_navigation/raw/master/repo_files/CircularBottomNavExample-0.0.3.apk)

<img src="https://github.com/benyaminbeyzaie/circular_bottom_navigation/raw/master/repo_files/images/uplabs_demo.gif" width="300">

This is implementation of an artwork in [Uplabs](https://www.uplabs.com/posts/bottom-tab)

<img src="https://github.com/benyaminbeyzaie/circular_bottom_navigation/raw/master/repo_files/images/demo.gif" width="300">

# Let's get started

## 1 - Install and import

### In your Dart code, you can use:

```kotlin
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
```

## 2 - CheatSheet

<img src="https://github.com/benyaminbeyzaie/circular_bottom_navigation/raw/master/repo_files/images/cheatsheet.png" width="700">

## 3 - Use it like a charm

### Make your TabItems

```dart
List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.search, "Search", Colors.orange, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    TabItem(Icons.layers, "Reports", Colors.red, circleStrokeColor: Colors.black),
    TabItem(Icons.notifications, "Notifications", Colors.cyan),
  ]);
```

### Use this widget everywhere you want

```dart
CircularBottomNavigation(
      tabItems,
      selectedCallback: (int selectedPos) {
        print("clicked on $selectedPos");
      },
    )
```

CircularBottomNavigation supports RTL designs, If you wrap your widget in a `Directionality` widget and set the `textDirection` property you can customize the direction:

```dart
MaterialApp(
  title: 'Circular Bottom Navigation Demo',
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: Directionality(
    // use this property to change direction in whole app
    // CircularBottomNavigation will act accordingly
    textDirection: TextDirection.rtl,
    child: MyHomePage(title: 'circular_bottom_navigation'),
  ),
);
```

### How to use CircularBottomNavigationController

With this controller you can read the current tab position, and set a tab position on widget (without needing to rebuild the tree) with the widget built in animation.

Just create a new instance of controller

```dart
CircularBottomNavigationController _navigationController =
new CircularBottomNavigationController(selectedPos);
```

Then pass it in your widget

```dart
CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
    );
```

Now you can write (set new position with animation) and read value from it everywhere you want

```dart
// Write a new value
_navigationController.value = 0;

// Read the latest value
int latest = _navigationController.value;
```
