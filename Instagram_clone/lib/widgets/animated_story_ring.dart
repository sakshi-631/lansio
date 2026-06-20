import 'package:flutter/material.dart';

class AnimatedStoryRing extends StatelessWidget {
  final String imageUrl;
  final String username;
  final bool isSeen;

  const AnimatedStoryRing({
    super.key,
    required this.imageUrl,
    required this.username,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isSeen
            ? const LinearGradient(
                colors: [
                  Color(0xFFFEDA75),
                  Color(0xFFFA7E1E),
                  Color(0xFFD62976),
                  Color(0xFF962FBF),
                  Color(0xFF4F5BD5),
                ],
              )
            : const LinearGradient(
                colors: [
                  Color(0xFFFEDA75),
                  Color(0xFFFA7E1E),
                  Color(0xFFD62976),
                  Color(0xFF962FBF),
                  Color(0xFF4F5BD5),
                ],
              ),
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
