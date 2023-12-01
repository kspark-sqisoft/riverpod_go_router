import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:riverpod_go_router/pages/medias/media_kit_video_player.dart';
import 'package:riverpod_go_router/providers/theme_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/*
final filePaths = [
  'D:/Pictures/savina/v6.jpg',
  'D:/Pictures/savina/v11.mp4',
  'D:/Pictures/savina/v8.jpg',
  'D:/Pictures/savina/v12.mp4',
  'D:/Pictures/savina/v7.jpg',
  'D:/Pictures/savina/v2.jpg',
];
*/
final paths = [
  'https://images.pexels.com/photos/1525041/pexels-photo-1525041.jpeg',
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  'https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg',
  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
  'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
  'https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg'
];
final intervals = [10, 10, 25, 10, 106, 10];

class CustomPhotoViewGallery extends ConsumerStatefulWidget {
  const CustomPhotoViewGallery({super.key});

  @override
  ConsumerState<CustomPhotoViewGallery> createState() =>
      _CustomPhotoViewGalleryState();
}

class _CustomPhotoViewGalleryState
    extends ConsumerState<CustomPhotoViewGallery> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);
    return Stack(
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          //allowImplicitScrolling: true, //이거 true 하면 비디오 안 멈춤
          backgroundDecoration: BoxDecoration(
              color: currentTheme is LightTheme ? Colors.white : Colors.black),
          pageController: _pageController,
          itemCount: paths.length,
          builder: (context, index) {
            final path = paths[index];
            final mimeType = lookupMimeType(path);
            if (mimeType!.startsWith('image/')) {
              if (path.startsWith('http')) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(
                    path,
                  ),
                );
              } else {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(
                    File(path),
                  ),
                );
              }
            } else if (mimeType.startsWith('video/')) {
              return PhotoViewGalleryPageOptions.customChild(
                disableGestures: true,
                child: MediaKitVideoPlayer(
                  path: path,
                ),
              );
            } else {
              return PhotoViewGalleryPageOptions.customChild(
                  child: Container());
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: paths.length,
              onDotClicked: (index) {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);

                //_pageController.jumpToPage(index);
              },
              effect: const WormEffect(activeDotColor: Colors.lightGreen),
            ),
          ),
        ),
      ],
    );
  }
}
