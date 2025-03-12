import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class AnimatedButtonUI extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final TransitionType transitionType;
  final bool shouldReverse;

  const AnimatedButtonUI({
    super.key,
    required this.text,
    this.width = 180,
    this.height = 55,
    required this.onPressed,
    this.transitionType = TransitionType.CENTER_LR_OUT,
    this.shouldReverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      isReverse: shouldReverse,
      width: width,
      height: height,
      text: text,
      selectedTextColor: Colors.white,
      selectedBackgroundColor: Colors.lightBlueAccent,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      borderColor: Colors.blueAccent,
      borderWidth: 2,
      transitionType: TransitionType.CENTER_LR_OUT,
      onPress: onPressed,
      borderRadius: 20,
    );
  }
}
