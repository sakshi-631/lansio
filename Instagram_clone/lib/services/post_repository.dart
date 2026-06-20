import 'dart:async';
import '../models/post_model.dart';

class PostRepository {
  // High-quality Unsplash images for posts
  final List<String> postImages = [
    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
    "https://images.unsplash.com/photo-1469474968028-56623f02e42e",
    "https://images.unsplash.com/photo-1441974231531-c6227db76b6e",
    "https://images.unsplash.com/photo-1470770841072-f978cf4d019e",
    "https://images.unsplash.com/photo-1469474968028-56623f02e42e",
    "https://images.unsplash.com/photo-1501785888041-af3ef285b470",
    "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    "https://images.unsplash.com/photo-1472214103451-9374bd1c798e",
    "https://images.unsplash.com/photo-1492724441997-5dc865305da7",
    "https://images.unsplash.com/photo-1441974231531-c6227db76b6e",
  ];

  // High-quality Unsplash profile images
  final List<String> profileImages = [
    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
    "https://images.unsplash.com/photo-1469474968028-56623f02e42e",
    "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde",
    "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
    "https://images.unsplash.com/photo-1502767089025-6572583495b4",
    "https://images.unsplash.com/photo-1527980965255-d3b416303d12",
    "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c",
    "https://images.unsplash.com/photo-1441974231531-c6227db76b6e",
  ];

  Future<List<Post>> fetchPosts(int page) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    return List.generate(10, (index) {
      final postImage1 = postImages[(index + page) % postImages.length];
      final postImage2 = postImages[(index + page + 1) % postImages.length];
      final avatar = profileImages[index % profileImages.length];

      return Post(
        username: "traveler_${page}_$index",
        avatar: avatar,
        caption: "new post",
        images: [postImage1, postImage2],
      );
    });
  }
}
