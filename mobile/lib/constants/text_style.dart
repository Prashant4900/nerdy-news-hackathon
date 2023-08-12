import 'package:flutter/material.dart';

TextStyle getTitleStyle(
  BuildContext context, {
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w600,
      );
}

TextStyle getDescriptionStyle(BuildContext context, {double? fontSize}) {
  return Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: fontSize,
      );
}

TextStyle getNewsSourceStyle(BuildContext context, {double? fontSize}) {
  return Theme.of(context).textTheme.bodySmall!.copyWith(
        fontSize: fontSize,
      );
}
