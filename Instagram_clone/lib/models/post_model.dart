class Post {
  final String username;
  final String avatar;
  final List<String> images;
  final String caption;

  bool isLiked;
  bool isSaved;
  int likes;

  Post({
    required this.username,
    required this.avatar,
    required this.images,
    required this.caption,
    this.isLiked = false,
    this.isSaved = false,
    this.likes = 0,
  });
}
