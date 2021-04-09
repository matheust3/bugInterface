import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? child;

  const Background({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 30, 30, 35),
              Color.fromARGB(255, 30, 30, 47)
            ],
          )),
          child: this.child,
        ),
      ),
    );
  }
}
