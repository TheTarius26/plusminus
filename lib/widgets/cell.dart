import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final Widget content;
  const Cell({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: content,
    );
  }
}
