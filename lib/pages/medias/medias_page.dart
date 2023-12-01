import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_go_router/pages/medias/custom_carousel_slider.dart';

import 'package:riverpod_go_router/pages/medias/custom_photo_view_gallery.dart';

import 'package:riverpod_go_router/providers/theme_provider.dart';

class MediasPage extends ConsumerStatefulWidget {
  const MediasPage({super.key});

  @override
  ConsumerState<MediasPage> createState() => _MediasPageState();
}

class _MediasPageState extends ConsumerState<MediasPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'MEDIA',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(themeProvider.notifier).toggleTheme();
                      },
                      icon: const Icon(Icons.light_mode),
                    ),
                  ],
                ),
              ),
              //const Expanded(child: CustomPhotoViewGallery())
              const Expanded(child: CustomCarouselSlider())
            ],
          ),
        ),
      ),
    );
  }
}
