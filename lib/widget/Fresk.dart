import "package:flutter/material.dart";

class Fresk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FreskState();
  }
}

class FreskState extends State<Fresk> {
  List<Widget> nodes = [];

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: nodes,
        ),
      ),
    );
  }
}
