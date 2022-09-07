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

<img src="https://github.com/benyaminbeyzaie/circular_bottom_navigation/raw/master/repo_files/images/cheatsheet.jpg" width="700">

## 3 - Use it like a charm

### Make your TabItems

```kotlin
List<TabItem> tabItems = List.of([
    TabItem(Icons.home, "Home", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
    TabItem(Icons.search, "Search", Colors.orange, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    TabItem(Icons.layers, "Reports", Colors.red),
    TabItem(Icons.notifications, "Notifications", Colors.cyan),
  ]);
```

### Use this widget everywhere you want

```kotlin
CircularBottomNavigation(
      tabItems,
      selectedCallback: (int selectedPos) {
        print("clicked on $selectedPos");
      },
    )
```

### How to use CircularBottomNavigationController

With this controller you can read the current tab position, and set a tab position on widget (without needing to rebuild the tree) with the widget built in animation.

Just create a new instance of controller

```kotlin
CircularBottomNavigationController _navigationController =
new CircularBottomNavigationController(selectedPos);
```

Then pass it in your widget

```kotlin
CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
    );
```

Now you can write (set new position with animation) and read value from it everywhere you want

```kotlin
// Write a new value
_navigationController.value = 0;

// Read the latest value
int latest = _navigationController.value;
```
