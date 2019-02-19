# Circular Bottom Navigation (or maybe a tab bar).
[![pub package](https://img.shields.io/pub/v/circular_bottom_navigation.svg)](https://pub.dartlang.org/packages/circular_bottom_navigation)
[![APK](https://img.shields.io/badge/APK-Demo-brightgreen.svg)](https://github.com/imaNNeoFighT/circular_bottom_navigation/raw/master/repo_files/CircularBottomNavExample-0.0.3.apk)

<img src="https://github.com/imaNNeoFighT/circular_bottom_navigation/raw/master/repo_files/images/uplabs_demo.gif" width="300">

This is implementation of an artwork in [Uplabs](https://www.uplabs.com/posts/bottom-tab)

<img src="https://github.com/imaNNeoFighT/circular_bottom_navigation/raw/master/repo_files/images/demo.gif" width="300">


# Let's get started

## 1 - Depend on it

### Add this to your package's pubspec.yaml file:

```kotlin
dependencies:
  circular_bottom_navigation: ^0.1.0
```

## 2 - Install it

### install packages from the command line:
```kotlin
flutter packages get
```

## 3 - Import it
### Now in your Dart code, you can use:
```kotlin
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
```

## 3 - Use it like a charm
### Make your TabItems
```kotlin
List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.blue),
    new TabItem(Icons.search, "Search", Colors.orange),
    new TabItem(Icons.layers, "Reports", Colors.red),
    new TabItem(Icons.notifications, "Notifications", Colors.cyan),
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

### how to use CircularBottomNavigationController

With this controller you can read the current tab position, and set a new tab position on widget (without needing to rebuild the tree) with the widget built in animation.

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