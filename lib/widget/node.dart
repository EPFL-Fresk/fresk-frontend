import "package:flutter/material.dart";

/// A node widget that displays an image and text when tapped.
class Node extends StatefulWidget {
  const Node({super.key, required this.name, required this.image, required this.description});

  final String name;
  final String image;
  final String description;

  @override
  State<Node> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  bool selected = false;
  bool showText = false; // Controls text visibility
  final double avatarDiameter = 128;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          if (selected) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                showText = true;
              });
            });
          } else {
            showText = false;
          }
        });
      },
      child: AnimatedContainer(
        width: selected ? avatarDiameter * 3 : avatarDiameter,
        height: selected ? avatarDiameter * 3 : avatarDiameter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
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
              NodeLogo(selected: selected, avatarDiameter: avatarDiameter, widget: widget),
              if (selected && showText) // Display text only after animation
                NodeText(avatarDiameter: avatarDiameter, widget: widget),
            ],
          ),
        ),
      ),
    );
  }
}

class NodeText extends StatelessWidget {
  const NodeText({
    super.key,
    required this.avatarDiameter,
    required this.widget,
  });

  final double avatarDiameter;
  final Node widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: avatarDiameter * 1.2,
      left: 16,
      right: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class NodeLogo extends StatelessWidget {
  const NodeLogo({
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
    return Positioned(
      top: selected ? 6.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
      left: selected ? 6.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: selected ? avatarDiameter : avatarDiameter,
        height: selected ? avatarDiameter : avatarDiameter,
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.image),
        ),
      ),
    );
  }
}
