import 'package:flutter/material.dart';

class ThickDivider extends StatelessWidget {
  const ThickDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Divider(thickness: 3),
    );
  }
}
