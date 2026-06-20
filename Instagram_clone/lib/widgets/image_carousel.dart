import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'pinch_zoom_overlay.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;

  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final image = widget.images[index];

              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (_) => PinchZoomOverlay(image: image),
                  );
                },

                child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        SmoothPageIndicator(
          controller: controller,
          count: widget.images.length,
          effect: const WormEffect(dotHeight: 8, dotWidth: 8),
        ),
      ],
    );
  }
}
