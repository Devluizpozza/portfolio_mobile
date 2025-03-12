import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextAlign? textAlign;

  const TitleSubtitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          textAlign == TextAlign.center
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: textAlign,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style:
              subtitleStyle ??
              Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
