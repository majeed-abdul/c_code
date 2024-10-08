import 'package:flutter/material.dart';
import 'dart:ui';

class Spinner extends StatelessWidget {
  const Spinner({
    super.key,
    required this.spinning,
    this.child = const SizedBox(),
  });

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
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
