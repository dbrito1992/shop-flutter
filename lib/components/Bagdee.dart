import 'package:flutter/material.dart';

class Bagdee extends StatelessWidget {
  final Widget child;
  final int value;
  final Color? color;
  const Bagdee({
    super.key,
    required this.child,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 1,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.secondary,
            ),
            constraints: BoxConstraints(minHeight: 16, minWidth: 16),
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
