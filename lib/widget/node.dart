import 'package:flutter/material.dart';

/// A round widget that contains an image.
class Node extends StatefulWidget {
  const Node({super.key, required this.image});

  final String image;

  @override
  State<Node> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  bool selected = false;
  final double avatarDiameter = 128;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected; // Toggle selection state
        });
      },
      child: AnimatedContainer(
        width: selected ? avatarDiameter * 3 : avatarDiameter,
        height: selected ? avatarDiameter * 2 : avatarDiameter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut, // Optional: Adds a smooth curve to the animation
        decoration: BoxDecoration(
          color: selected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          border: Border.all(color: Colors.white, width: 6.0),
          borderRadius:
              BorderRadius.circular(selected ? 16 : avatarDiameter / 2),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(selected ? 16 : avatarDiameter / 2),
          child: Stack(
            children: [
              // Other widgets can be added here when expanded
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                top: selected ? 6.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
                left: selected ? 6.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
                child: CircleAvatar(
                  radius: avatarDiameter / 2,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
