import 'package:flutter/material.dart';
import 'package:instagram_feed/widgets/story_viewer.dart';
import 'animated_story_ring.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  static final List<String> images = [
    "https://i.pravatar.cc/150?img=1",
    "https://i.pravatar.cc/150?img=2",
    "https://i.pravatar.cc/150?img=3",
    "https://i.pravatar.cc/150?img=4",
    "https://i.pravatar.cc/150?img=5",
    "https://i.pravatar.cc/150?img=6",
    "https://i.pravatar.cc/150?img=7",
    "https://i.pravatar.cc/150?img=8",
    "https://i.pravatar.cc/150?img=9",
    "https://i.pravatar.cc/150?img=10",
    "https://i.pravatar.cc/150?img=11",
    "https://i.pravatar.cc/150?img=13",
    "https://i.pravatar.cc/150?img=14",
    "https://i.pravatar.cc/150?img=15",
  ];

  static final List<String> usernames = [
    "nidhi_jdhv",
    "sakshii_mane",
    "kunal_k",
    "rahul_07",
    "riya_p",
    "rohit_23",

    // NEW UNIQUE USERNAMES
    "anaya_s",
    "vikram_p",
    "tanvi_k",
    "aditya_r",
    "megha_d",
    "sahil_v",
    "neha_t",
    "karan_m",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          /// YOUR STORY
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?img=12",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Your story",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            );
          }

          /// OTHER STORIES
          final storyIndex = index - 1;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoryViewer(
                          images: images,
                          initialIndex: storyIndex,
                          username: usernames[storyIndex],
                        ),
                      ),
                    );
                  },
                  child: AnimatedStoryRing(
                    imageUrl: images[storyIndex],
                    username: usernames[storyIndex],
                    isSeen: false,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  usernames[storyIndex],
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
