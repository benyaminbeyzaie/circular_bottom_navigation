# Circular Bottom Navigation (or maybe a tab bar).

This is implementation of an artwork in [Uplabs](https://www.uplabs.com/posts/bottom-tab)

<p>
    <img src="https://assets.materialup.com/uploads/25695b47-0c7f-479f-81d3-0e9d6edd06cf/preview.gif" width="300">
    <img src="https://github.com/imaNNeoFighT/circular_bottom_navigation/blob/master/repo_files/images/demo.gif" width="300">
</p>


#### Go through this instruction to use this package in your flutter app

## 1 - Depend on it

### Add this to your package's pubspec.yaml file:

```kotlin
dependencies:
  circular_bottom_navigation: ^0.0.2
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