
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videodownload/core/theme/app_palette.dart';

Widget customNetworkBuilder({
  required String imageUrl,
  double? height = double.infinity,
  double? width = double.infinity,
  BoxFit boxfit = BoxFit.cover,
  int? cacheWidth,
  int? cacheHeight,
  double? aspectRatio,
}) {
  Widget image = Image.network(
    imageUrl,
    width: width,
    height: height,
    fit: boxfit,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
    filterQuality: FilterQuality.high,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;

      final totalBytes = loadingProgress.expectedTotalBytes;
      final loadedBytes = loadingProgress.cumulativeBytesLoaded;
      final progress = totalBytes != null ? loadedBytes / totalBytes : null;

      return SizedBox(
        width: width,
        height: height,
        child: Center(
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 2,
            backgroundColor: AppPalette.white,
            color: AppPalette.button,
          ),
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(color: AppPalette.hint),
            Icon(CupertinoIcons.photo, size: 28, color: AppPalette.grey),
            Positioned(
              child: Text(
                'Load failed',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: AppPalette.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    },
  );

  if (aspectRatio != null) {
    return AspectRatio(aspectRatio: aspectRatio, child: image);
  }

  return image;
}
