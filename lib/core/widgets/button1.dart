import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const Button1({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 17),
      ),
    );
  }
}
