import 'dart:async';

import 'package:flutter/material.dart';

class GameLaunchScreen extends StatefulWidget {
  const GameLaunchScreen({
    required this.color,
    required this.child,
    super.key,
  });

  final Color color;
  final Widget child;

  @override
  State<GameLaunchScreen> createState() => _GameLaunchScreenState();
}

class _GameLaunchScreenState extends State<GameLaunchScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(builder: (context) => widget.child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
    );
  }
}
