import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;

  const CachedNetworkImageWidget(
      {super.key, required this.image, this.height, this.width, this.fit});

  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return image != null
        ? CachedNetworkImage(
            imageUrl: image ?? '',
            height: height,
            width: width,
            errorWidget: (context, url, error) =>
                const Center(child: AppLoder()),
            fit: fit ?? BoxFit.cover,
          )
        : SizedBox.shrink();
  }
}
