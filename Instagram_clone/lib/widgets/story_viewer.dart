import 'dart:async';
import 'package:flutter/material.dart';

class StoryViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String username;

  const StoryViewer({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.username,
  });

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController progressController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex;

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    startStory();
  }

  void startStory() {
    progressController.forward();

    progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextStory();
      }
    });
  }

  void nextStory() {
    if (currentIndex < widget.images.length - 1) {
      setState(() {
        currentIndex++;
      });

      progressController.reset();
      startStory();
    } else {
      Navigator.pop(context);
    }
  }

  void previousStory() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });

      progressController.reset();
      startStory();
    }
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// SWIPE DOWN TO CLOSE
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 10) {
          Navigator.pop(context);
        }
      },

      /// TAP LEFT / RIGHT
      onTapDown: (details) {
        final width = MediaQuery.of(context).size.width;

        if (details.globalPosition.dx < width / 2) {
          previousStory();
        } else {
          nextStory();
        }
      },

      child: Scaffold(
        backgroundColor: Colors.black,

        body: Stack(
          children: [
            /// STORY IMAGE
            Center(
              child: Image.network(
                widget.images[currentIndex],
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),

            /// PROGRESS BARS
            Positioned(
              top: 50,
              left: 10,
              right: 10,

              child: Row(
                children: List.generate(widget.images.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),

                      child: LinearProgressIndicator(
                        value: index < currentIndex
                            ? 1
                            : index == currentIndex
                            ? progressController.value
                            : 0,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            /// TOP USER BAR
            Positioned(
              top: 80,
              left: 16,
              right: 16,

              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.images[currentIndex]),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    widget.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
