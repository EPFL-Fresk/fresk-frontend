import "package:flutter/material.dart";

/// A round widget that contains an image.
class Node extends StatefulWidget {
  const Node({super.key, required this.name, required this.image});

  final String name;
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
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          border: Border.all(color: Colors.white, width: 6.0),
          borderRadius:
              BorderRadius.circular(selected ? 16 : avatarDiameter / 2),
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(selected ? 16 : avatarDiameter / 2),
          child: Stack(
            children: [
              Logo(selected: selected, avatarDiameter: avatarDiameter, widget: widget),
            ],
          ),
        ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.selected,
    required this.avatarDiameter,
    required this.widget,
  });

  final bool selected;
  final double avatarDiameter;
  final Node widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      top: selected ? 6.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
      left: selected ? 6.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
      child: CircleAvatar(
        radius: selected ? avatarDiameter / 4 : avatarDiameter / 2,
        backgroundImage: NetworkImage(widget.image),
      ),
    );
  }
}
