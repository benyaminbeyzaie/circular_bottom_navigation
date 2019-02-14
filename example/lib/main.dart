import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.blue),
    new TabItem(Icons.search, "Search", Colors.orange),
    new TabItem(Icons.layers, "Reports", Colors.red),
    new TabItem(Icons.notifications, "Notifications", Colors.cyan),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(child: bodyContainer(), padding: EdgeInsets.only(bottom: bottomNavBarHeight),),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Color selectedColor = tabItems[selectedPos].color;
    String slogan;
    switch (selectedPos) {
      case 0:
        slogan = "Home is better than office";
        break;
      case 1:
        slogan = "Search to find yourself";
        break;
      case 2:
        slogan = "Skip all Reports";
        break;
      case 3:
        slogan = "Notifications will disturbing you";
        break;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: selectedColor,
      child: Center(
        child: Text(
          slogan,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      barHeight: bottomNavBarHeight,
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
        });
      },
    );
  }
}
