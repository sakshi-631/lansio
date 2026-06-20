import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository repository = PostRepository();

  List<Post> posts = [];
  bool isLoading = false;
  int page = 1;

  Future<void> loadPosts() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final newPosts = await repository.fetchPosts(page);

    posts.addAll(newPosts);

    page++;

    isLoading = false;
    notifyListeners();
  }
}
