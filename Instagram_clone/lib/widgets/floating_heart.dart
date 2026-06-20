import 'package:flutter/material.dart';

class FloatingHeart extends StatefulWidget {
  final Offset position;

  const FloatingHeart({super.key, required this.position});

  @override
  State<FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<FloatingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> opacity;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    animation = Tween<double>(
      begin: 0,
      end: -120,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    opacity = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          left: widget.position.dx - 20,
          top: widget.position.dy + animation.value,
          child: Opacity(
            opacity: opacity.value,
            child: Transform.scale(
              scale: 1 + controller.value * 0.5,
              child: const Icon(Icons.favorite, color: Colors.red, size: 40),
            ),
          ),
        );
      },
    );
  }
}
