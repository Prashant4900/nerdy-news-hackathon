import 'package:flutter/material.dart';
import 'package:mobile/constants/text_style.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTitleStyle(context, fontSize: 18),
          ),
          Text(
            description,
            style: getDescriptionStyle(context, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
