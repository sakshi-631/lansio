// import 'package:flutter/material.dart';
// import '../models/post_model.dart';
// import 'floating_heart.dart';

// class PostWidget extends StatefulWidget {
//   final Post post;

//   const PostWidget({super.key, required this.post});

//   @override
//   State<PostWidget> createState() => _PostWidgetState();
// }

// class _PostWidgetState extends State<PostWidget>
//     with SingleTickerProviderStateMixin {
//   /// floating heart animation
//   List<Offset> hearts = [];

//   /// carousel controller
//   final PageController pageController = PageController();
//   int currentPage = 0;

//   /// zoom variables
//   double scale = 1.0;
//   late AnimationController zoomController;
//   late Animation<double> zoomAnimation;

//   @override
//   void initState() {
//     super.initState();

//     zoomController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );

//     zoomAnimation = Tween<double>(begin: 1, end: 1).animate(zoomController)
//       ..addListener(() {
//         setState(() {
//           scale = zoomAnimation.value;
//         });
//       });
//   }

//   @override
//   void dispose() {
//     zoomController.dispose();
//     pageController.dispose();
//     super.dispose();
//   }

//   /// LIKE TOGGLE
//   void likePost() {
//     final post = widget.post;

//     setState(() {
//       if (!post.isLiked) {
//         post.isLiked = true;
//         post.likes++;
//       } else {
//         post.isLiked = false;
//         post.likes--;
//       }
//     });
//   }

//   /// SAVE TOGGLE
//   void toggleSave() {
//     setState(() {
//       widget.post.isSaved = !widget.post.isSaved;
//     });
//   }

//   /// DOUBLE TAP HEARTS
//   void showHearts(Offset position) {
//     setState(() {
//       for (int i = 0; i < 4; i++) {
//         hearts.add(position);
//       }
//     });

//     Future.delayed(const Duration(milliseconds: 900), () {
//       setState(() {
//         hearts.clear();
//       });
//     });
//   }

//   /// SNACKBAR FOR UNIMPLEMENTED BUTTONS
//   void showSnackbar(String text) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(text),
//         duration: const Duration(seconds: 3),
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   /// RESET ZOOM ANIMATION
//   void resetZoom() {
//     zoomAnimation = Tween<double>(
//       begin: scale,
//       end: 1,
//     ).animate(CurvedAnimation(parent: zoomController, curve: Curves.easeOut));

//     zoomController.forward(from: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final post = widget.post;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// USER HEADER
//         ListTile(
//           leading: CircleAvatar(backgroundImage: NetworkImage(post.avatar)),
//           title: Text(post.username),
//           trailing: const Icon(Icons.more_vert),
//         ),

//         /// IMAGE AREA WITH CAROUSEL + PINCH ZOOM
//         GestureDetector(
//           /// DOUBLE TAP LIKE
//           onDoubleTapDown: (details) {
//             if (!post.isLiked) {
//               setState(() {
//                 post.isLiked = true;
//                 post.likes++;
//               });
//             }

//             showHearts(details.localPosition);
//           },

//           /// PINCH ZOOM
//           onScaleUpdate: (details) {
//             setState(() {
//               scale = details.scale.clamp(1.0, 3.0);
//             });
//           },

//           /// RETURN TO NORMAL SIZE
//           onScaleEnd: (_) {
//             resetZoom();
//           },

//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               /// IMAGE CAROUSEL
//               Transform.scale(
//                 scale: scale,
//                 child: SizedBox(
//                   height: 350,
//                   child: PageView.builder(
//                     controller: pageController,
//                     itemCount: post.images.length,

//                     onPageChanged: (index) {
//                       setState(() {
//                         currentPage = index;
//                       });
//                     },

//                     itemBuilder: (context, index) {
//                       return Image.network(
//                         post.images[index],
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               /// FLOATING HEARTS
//               ...hearts.map((pos) => FloatingHeart(position: pos)).toList(),

//               /// DOT INDICATOR
//               if (post.images.length > 1)
//                 Positioned(
//                   bottom: 12,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(post.images.length, (index) {
//                       bool isActive = currentPage == index;

//                       return AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         margin: const EdgeInsets.symmetric(horizontal: 3),
//                         width: isActive ? 8 : 6,
//                         height: isActive ? 8 : 6,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: isActive ? Colors.white : Colors.white54,
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         /// ACTION BUTTONS
//         Row(
//           children: [
//             /// LIKE BUTTON
//             IconButton(
//               icon: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 250),
//                 transitionBuilder: (child, animation) =>
//                     ScaleTransition(scale: animation, child: child),
//                 child: Icon(
//                   post.isLiked ? Icons.favorite : Icons.favorite_border,
//                   key: ValueKey(post.isLiked),
//                   color: post.isLiked ? Colors.red : Colors.black,
//                 ),
//               ),
//               onPressed: likePost,
//             ),

//             /// COMMENT BUTTON
//             IconButton(
//               icon: const Icon(Icons.chat_bubble_outline),
//               onPressed: () {
//                 showSnackbar("Comments feature coming soon");
//               },
//             ),

//             /// SHARE BUTTON
//             IconButton(
//               icon: const Icon(Icons.send_outlined),
//               onPressed: () {
//                 showSnackbar("Share feature coming soon");
//               },
//             ),

//             const Spacer(),

//             /// SAVE BOOKMARK
//             IconButton(
//               icon: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_border),
//               onPressed: toggleSave,
//             ),
//           ],
//         ),

//         /// LIKE COUNT
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 300),
//             child: Text(
//               "${post.likes} likes",
//               key: ValueKey(post.likes),
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),

//         /// CAPTION
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//           child: Text(post.caption),
//         ),

//         const SizedBox(height: 20),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/post_model.dart';
import 'floating_heart.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with SingleTickerProviderStateMixin {
  /// floating hearts
  List<Offset> hearts = [];

  /// carousel controller
  final PageController pageController = PageController();
  int currentPage = 0;

  /// zoom variables
  double scale = 1.0;
  double baseScale = 1.0;
  bool isZooming = false;

  late AnimationController zoomController;
  late Animation<double> zoomAnimation;

  @override
  void initState() {
    super.initState();

    zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    zoomAnimation = Tween<double>(begin: 1, end: 1).animate(zoomController)
      ..addListener(() {
        setState(() {
          scale = zoomAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    zoomController.dispose();
    pageController.dispose();
    super.dispose();
  }

  /// LIKE TOGGLE
  void likePost() {
    final post = widget.post;

    setState(() {
      if (!post.isLiked) {
        post.isLiked = true;
        post.likes++;
      } else {
        post.isLiked = false;
        post.likes--;
      }
    });
  }

  /// SAVE TOGGLE
  void toggleSave() {
    setState(() {
      widget.post.isSaved = !widget.post.isSaved;
    });
  }

  /// DOUBLE TAP HEARTS
  void showHearts(Offset position) {
    setState(() {
      for (int i = 0; i < 4; i++) {
        hearts.add(position);
      }
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        hearts.clear();
      });
    });
  }

  /// SNACKBAR
  void showSnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// RESET ZOOM
  void resetZoom() {
    zoomAnimation = Tween<double>(
      begin: scale,
      end: 1,
    ).animate(CurvedAnimation(parent: zoomController, curve: Curves.easeOut));

    zoomController.forward(from: 0);

    setState(() {
      isZooming = false;
      baseScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// USER HEADER
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(post.avatar)),
          title: Text(post.username),
          trailing: const Icon(Icons.more_vert),
        ),

        /// IMAGE AREA
        GestureDetector(
          /// DOUBLE TAP LIKE
          onDoubleTapDown: (details) {
            if (!post.isLiked) {
              setState(() {
                post.isLiked = true;
                post.likes++;
              });
            }

            showHearts(details.localPosition);
          },

          /// PINCH START
          onScaleStart: (details) {
            baseScale = scale;
            setState(() {
              isZooming = true;
            });
          },

          /// PINCH UPDATE
          onScaleUpdate: (details) {
            setState(() {
              scale = (baseScale * details.scale).clamp(1.0, 3.0);
            });
          },

          /// PINCH END
          onScaleEnd: (_) {
            resetZoom();
          },

          child: Stack(
            alignment: Alignment.center,
            children: [
              /// IMAGE CAROUSEL
              Transform.scale(
                scale: scale,
                child: SizedBox(
                  height: 350,
                  child: PageView.builder(
                    controller: pageController,

                    /// disable swipe while zooming
                    physics: isZooming
                        ? const NeverScrollableScrollPhysics()
                        : const BouncingScrollPhysics(),

                    itemCount: post.images.length,

                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },

                    itemBuilder: (context, index) {
                      return Image.network(
                        post.images[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),

              /// FLOATING HEARTS
              ...hearts.map((pos) => FloatingHeart(position: pos)).toList(),

              /// DOT INDICATOR
              if (post.images.length > 1)
                Positioned(
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(post.images.length, (index) {
                      bool active = currentPage == index;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 8 : 6,
                        height: active ? 8 : 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active ? Colors.white : Colors.white54,
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ),

        /// ACTION BUTTONS
        Row(
          children: [
            /// LIKE
            IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(post.isLiked),
                  color: post.isLiked ? Colors.red : Colors.black,
                ),
              ),
              onPressed: likePost,
            ),

            /// COMMENT
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {
                showSnackbar("Comments feature coming soon");
              },
            ),

            /// SHARE
            IconButton(
              icon: const Icon(Icons.send_outlined),
              onPressed: () {
                showSnackbar("Share feature coming soon");
              },
            ),

            const Spacer(),

            /// SAVE
            IconButton(
              icon: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_border),
              onPressed: toggleSave,
            ),
          ],
        ),

        /// LIKE COUNT
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              "${post.likes} likes",
              key: ValueKey(post.likes),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        /// CAPTION
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(post.caption),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
