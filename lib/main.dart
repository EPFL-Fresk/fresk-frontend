import "package:flutter/material.dart";
import "package:fresk/model/association.dart";
import "package:fresk/screen/HomeScreen.dart";
import "package:fresk/utils/data.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  late Future<List<Association>> associations;

  @override
  void initState() {
    super.initState();

    associations = fetchAssociations();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
