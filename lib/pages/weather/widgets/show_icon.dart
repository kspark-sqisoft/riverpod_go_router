import 'package:flutter/material.dart';
import 'package:riverpod_go_router/pages/weather/constants/constants.dart';

class ShowIcon extends StatelessWidget {
  final String icon;
  const ShowIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'https://$kIconHost/img/wn/$icon@4x.png',
      width: 200,
      height: 200,
      imageErrorBuilder: (context, e, st) {
        return Image.asset(
          'assets/images/no_image_icon.png',
          width: 200,
          height: 200,
        );
      },
    );
  }
}
