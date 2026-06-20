import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post_provider.dart';
import '../widgets/post_widget.dart';
import '../widgets/story_section.dart';
import '../widgets/shimmer_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      final provider = context.read<PostProvider>();

      if (controller.position.pixels >
          controller.position.maxScrollExtent - 600) {
        provider.loadPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,

        /// LEFT ICON
        leading: const Icon(Icons.add_box_outlined, color: Colors.black),

        /// INSTAGRAM TEXT
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 32,
            color: Colors.black,
          ),
        ),

        /// RIGHT ICONS
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 18),
          Icon(Icons.message_outlined, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),

      body: ListView.builder(
        controller: controller,
        itemCount: provider.posts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const StorySection();
          }

          if (index - 1 < provider.posts.length) {
            return PostWidget(post: provider.posts[index - 1]);
          }

          return const ShimmerPost();
        },
      ),
    );
  }
}
