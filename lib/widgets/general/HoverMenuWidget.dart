import 'package:flutter/material.dart';

class HoverMenuWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  HoverMenuWidget({
    required this.child,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  _HoverMenuWidgetState createState() => _HoverMenuWidgetState();
}

class _HoverMenuWidgetState extends State<HoverMenuWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
      }),
      onExit: (event) => setState(() {
        _isHovered = false;
      }),
      child: Stack(
        children: [
          widget.child,
          if (_isHovered)
            Positioned(
              right: 220,
              top: 0,
              child: Card(
                elevation: 4,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: widget.onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: widget.onDelete,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
