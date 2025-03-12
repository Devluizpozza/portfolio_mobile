import 'package:flutter/material.dart';

class BackgroundImageBuilder extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  const BackgroundImageBuilder({
    required this.child,
    this.imageUrl = "assets/images/background.jpg",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
