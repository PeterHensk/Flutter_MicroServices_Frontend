import 'package:flutter/material.dart';

enum HoverMenuAction { edit, delete, report }

class HoverMenuWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;
  final List<HoverMenuAction> actions;

  const HoverMenuWidget({
    super.key,
    required this.child,
    this.onEdit,
    this.onDelete,
    this.onReport,
    required this.actions,
  });

  @override
  _HoverMenuWidgetState createState() => _HoverMenuWidgetState();
}

class _HoverMenuWidgetState extends State<HoverMenuWidget> {
  bool _isHovered = false;

  Widget _buildActionButton(HoverMenuAction action) {
    switch (action) {
      case HoverMenuAction.edit:
        return Tooltip(
          message: 'Edit',
          child: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: widget.onEdit,
          ),
        );
      case HoverMenuAction.delete:
        return Tooltip(
          message: 'Delete',
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        );
      case HoverMenuAction.report:
        return Tooltip(
          message: 'Report',
          child: IconButton(
            icon: const Icon(Icons.report_problem),
            onPressed: widget.onReport,
          ),
        );
      default:
        return Container();
    }
  }

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
                  children: widget.actions
                      .map((action) => _buildActionButton(action))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
