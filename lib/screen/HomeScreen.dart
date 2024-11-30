import 'package:flutter/material.dart';
import "package:fresk/widget/Fresk.dart";

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fresk(),
    );
  }
}
