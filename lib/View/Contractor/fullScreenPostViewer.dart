// // lib/View/Contractor/FullScreenPostViewer.dart

// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart'; // <<< Requires 'video_player' package

// class FullScreenPostViewer extends StatefulWidget {
//   final String postUrl;
//   final bool isVideo;

//   const FullScreenPostViewer({
//     super.key,
//     required this.postUrl,
//     required this.isVideo,
//   });

//   @override
//   State<FullScreenPostViewer> createState() => _FullScreenPostViewerState();
// }

// class _FullScreenPostViewerState extends State<FullScreenPostViewer> {
//   late VideoPlayerController _controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isVideo) {
//       _controller = VideoPlayerController.networkUrl(Uri.parse(widget.postUrl))
//         ..initialize()
//             .then((_) {
//               setState(() {
//                 _isLoading = false;
//                 _controller.play(); // Start playback immediately
//                 _controller.setLooping(true); // Loop the video
//               });
//             })
//             .catchError((error) {
//               setState(() {
//                 _isLoading = false;
//                 // Handle video loading error
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error loading video: $error')),
//                 );
//               });
//             });
//     } else {
//       _isLoading = false;
//     }
//   }

//   @override
//   void dispose() {
//     if (widget.isVideo) {
//       _controller.dispose();
//     }
//     super.dispose();
//   }

//   Widget _buildVideoPlayer() {
//     if (_isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       );
//     }
//     if (_controller.value.isInitialized) {
//       return Stack(
//         alignment: Alignment.bottomCenter,
//         children: <Widget>[
//           // Video Display
//           AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ),
//           // Control Bar
//           VideoProgressIndicator(
//             _controller,
//             allowScrubbing: true,
//             colors: const VideoProgressColors(
//               playedColor: Colors.red,
//               bufferedColor: Colors.white70,
//               backgroundColor: Colors.transparent,
//             ),
//           ),
//           // Play/Pause button
//           Center(
//             child: IconButton(
//               icon: Icon(
//                 _controller.value.isPlaying
//                     ? Icons.pause_circle_outline
//                     : Icons.play_circle_outline,
//                 size: 80.0,
//                 color: Colors.white.withOpacity(0.8),
//               ),
//               onPressed: () {
//                 setState(() {
//                   _controller.value.isPlaying
//                       ? _controller.pause()
//                       : _controller.play();
//                 });
//               },
//             ),
//           ),
//         ],
//       );
//     } else {
//       return const Center(
//         child: Icon(Icons.error_outline, color: Colors.white, size: 60),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Dark background for media viewing
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.close, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Center(
//         child: widget.isVideo
//             ? _buildVideoPlayer()
//             : InteractiveViewer(
//                 // Allows zoom/pan for images
//                 child: Image.network(
//                   widget.postUrl,
//                   fit: BoxFit.contain, // Show image fully without cropping
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                   loadingProgress.expectedTotalBytes!
//                             : null,
//                         color: Colors.white,
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) => const Center(
//                     child: Icon(
//                       Icons.broken_image,
//                       color: Colors.white,
//                       size: 60,
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }















// lib/View/Contractor/FullScreenPostViewer.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // <<< Requires 'video_player' package

class FullScreenPostViewer extends StatefulWidget {
  final String postUrl;
  final bool isVideo;

  const FullScreenPostViewer({
    super.key,
    required this.postUrl,
    required this.isVideo,
  });

  @override
  State<FullScreenPostViewer> createState() => _FullScreenPostViewerState();
}

class _FullScreenPostViewerState extends State<FullScreenPostViewer> {
  late VideoPlayerController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.postUrl))
        ..initialize()
            .then((_) {
              setState(() {
                _isLoading = false;
                _controller.play(); // Start playback immediately
                _controller.setLooping(true); // Loop the video
              });
            })
            .catchError((error) {
              setState(() {
                _isLoading = false;
                // Handle video loading error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error loading video: $error')),
                );
              });
            });
    } else {
      _isLoading = false;
    }
  }

  @override
  void dispose() {
    if (widget.isVideo) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget _buildVideoPlayer() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    if (_controller.value.isInitialized) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // Video Display
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          // Control Bar
          VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Colors.red,
              bufferedColor: Colors.white70,
              backgroundColor: Colors.transparent,
            ),
          ),
          // Play/Pause button
          Center(
            child: IconButton(
              icon: Icon(
                _controller.value.isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
                size: 80.0,
                color: Colors.white.withOpacity(0.8),
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Icon(Icons.error_outline, color: Colors.white, size: 60),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for media viewing
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: widget.isVideo
            ? _buildVideoPlayer()
            : InteractiveViewer(
                // Allows zoom/pan for images
                child: Image.network(
                  widget.postUrl,
                  fit: BoxFit.contain, // Show image fully without cropping
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: Colors.white,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}