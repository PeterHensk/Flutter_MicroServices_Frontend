import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 0 ? onPreviousPage : null,
          icon: const Icon(
            Icons.keyboard_double_arrow_left,
          ),
        ),
        const SizedBox(width: 16),
        Text('Page ${currentPage + 1} of $totalPages'),
        const SizedBox(width: 16),
        IconButton(
          onPressed: currentPage < totalPages - 1 ? onNextPage : null,
          icon: const Icon(
            Icons.keyboard_double_arrow_right,
          ),
        ),
      ],
    );
  }
}
