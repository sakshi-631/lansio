import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PinchZoomOverlay extends StatelessWidget {
  final String image;

  const PinchZoomOverlay({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),

      child: Scaffold(
        backgroundColor: Colors.black,

        body: Center(
          child: InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: CachedNetworkImage(imageUrl: image),
          ),
        ),
      ),
    );
  }
}
