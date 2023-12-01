import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:riverpod_go_router/main.dart';
import 'package:riverpod_go_router/providers/theme_provider.dart';

class MediaKitVideoPlayer extends ConsumerStatefulWidget {
  const MediaKitVideoPlayer({
    super.key,
    required this.path,
  });
  final String path;

  @override
  ConsumerState<MediaKitVideoPlayer> createState() =>
      _MediaKitVideoPlayerState();
}

class _MediaKitVideoPlayerState extends ConsumerState<MediaKitVideoPlayer> {
  late final player = Player();

  late final controller = VideoController(player);

  @override
  void initState() {
    print('MediaKitVideoPlayer initState');
    //player.setPlaylistMode(PlaylistMode.single); //하나 비디오 반복 재생
    player.open(Media(widget.path));
    super.initState();
  }

  @override
  void dispose() {
    print('MediaKitVideoPlayer dispose');
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(changeRouteProvider, (p, n) {
      if (n.routeType == ChangeRouteType.restoring &&
          n.routeName == '/medias') {
        controller.player.play();
      } else {
        controller.player.pause();
      }
    });

    final currentTheme = ref.watch(themeProvider);
    return Video(
        controller: controller,
        controls: NoVideoControls,
        fill: currentTheme is LightTheme ? Colors.white : Colors.black);
  }
}
