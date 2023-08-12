import 'package:flutter/material.dart';
import 'package:mobile/constants/text_style.dart';

class GameListCardWidget extends StatelessWidget {
  const GameListCardWidget({
    required this.image,
    required this.title,
    required this.description,
    this.onTap,
    super.key,
  });

  final Widget image;
  final String title;
  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: getTitleStyle(context, fontSize: 16),
                      ),
                      Text(
                        description,
                        style: getDescriptionStyle(context, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
