import 'dart:ui';
import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner(
      {Key? key, required this.spinning, this.child = const SizedBox()})
      : super(key: key);

  final bool spinning;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: spinning,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Image.asset(
                  'assets/loader.gif',
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
