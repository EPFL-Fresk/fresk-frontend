import "package:flutter/material.dart";

/// A widget representing a node in the graph
/// Expands when tapped and displays text below the image.
/// The widget can be tapped again to collapse.
/// [name] is the name of the node.
/// [image] is the URL of the image to display.
/// [description] is the description of the node.
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
    return GestureDetector( // Tap on widget to select
      onTap: () {
        setState(() {
          selected = !selected;
          if (selected) {
            // Delay text display to after animation
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
          color: selected ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white, width: 6.0),
          borderRadius:
              BorderRadius.circular(selected ? 16 : avatarDiameter / 2), // Rectangle on selected, else circle
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
      top: avatarDiameter * 1.2, // Position text below the avatar
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

/// Displays the logo of the node
/// [selected] is true if the node is selected.
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
    return AnimatedPositioned(
      top: selected ? 8.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
      left: selected ? 8.0 : (avatarDiameter / 2) - (avatarDiameter / 2),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: avatarDiameter,
        height: avatarDiameter,
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.image),
        ),
    );
  }
}
