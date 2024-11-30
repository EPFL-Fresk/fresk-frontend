import 'package:flutter/material.dart';

/// A widget that toggles between a circular and square shape on tap.
class Node extends StatefulWidget {
  const Node({super.key, required this.image});

  final String image;

  @override
  State<Node> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  bool selected = false;
  final double diameter = 128;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected; // Toggle selection state
        });
      },
      child: AnimatedContainer(
        width: selected ? diameter * 2 : diameter,
        height: selected ? diameter * 2 : diameter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(selected ? diameter/4 : diameter / 2),
          border: Border.all(color: Colors.white, width: 6.0), // White border
          image: DecorationImage(
            image: NetworkImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
    );
  }
}
