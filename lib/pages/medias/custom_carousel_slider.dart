import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:riverpod_go_router/main.dart';
import 'package:riverpod_go_router/pages/medias/media_kit_video_player.dart';

import 'package:collection/collection.dart';

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
final intervals = [
  10,
  60 * 10 + 53,
  25,
  60 * 12 + 14,
  60 * 9 + 56,
  10,
];

class CustomCarouselSlider extends ConsumerStatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends ConsumerState<CustomCarouselSlider> {
  final CarouselController _carouselController = CarouselController();

  int _current = 0;
  int _dynamicInterval = intervals[0];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build-------------------- $_dynamicInterval');

    ref.listen(changeRouteProvider, (p, n) {
      if (n.routeType == ChangeRouteType.going && n.routeName == '/medias') {
        setState(() {
          _current = 0;
          _dynamicInterval = intervals[0];
        });
        _carouselController.animateToPage(_current);
      }
    });

    return Stack(
      children: [
        Align(
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: _dynamicInterval),
              onPageChanged: (index, reasen) {
                print('reason:$reasen');

                setState(() {
                  _current = index;
                  _dynamicInterval = intervals[index];
                });

                if (reasen == CarouselPageChangedReason.controller) {
                } else {
                  _carouselController.animateToPage(_current);
                }
              },
            ),
            itemCount: paths.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final path = paths[itemIndex];

              final mimeType = lookupMimeType(path);
              if (mimeType!.startsWith('image/')) {
                if (path.startsWith('http')) {
                  return Image.network(
                    path,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  );
                }
              } else {
                return MediaKitVideoPlayer(path: path);
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: paths.mapIndexed((index, entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(index),
                  child: Stack(
                    children: [
                      Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.black.withOpacity(0.3))),
                      ),
                      Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.lightGreen
                                        : Colors.lightBlue)
                                    .withOpacity(_current == index ? 1 : 0)),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
