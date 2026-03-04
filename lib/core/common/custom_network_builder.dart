import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videodownload/core/common/custom_cache_manager.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';

Widget customNetworkBuilder({
  required String imageUrl,
  double? height,
  double? width,
  BoxFit boxfit = BoxFit.cover,
  int? cacheWidth,
  int? cacheHeight,
  double? aspectRatio,
  BorderRadius? borderRadius,
  BoxDecoration? decoration,
  bool isCached = false,
}) {
  final int? mWidth =
      cacheWidth ??
      (width != null && width != double.infinity ? (width * 2).toInt() : null);
  final int? mHeight =
      cacheHeight ??
      (height != null && height != double.infinity
          ? (height * 2).toInt()
          : null);

  Widget image;

  if (isCached) {
    image = CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: CustomCacheManager.instance,
      width: width,
      height: height,
      fit: boxfit,
      memCacheWidth: mWidth,
      memCacheHeight: mHeight,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: (decoration ?? const BoxDecoration()).copyWith(
          color: AppPalette.hint.withValues(alpha: 0.1),
          borderRadius: borderRadius,
        ),
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: AppPalette.white,
            color: AppPalette.button,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>
          _buildErrorWidget(context, width, height, borderRadius, decoration),
      imageBuilder: borderRadius != null || decoration != null
          ? (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: (decoration ?? const BoxDecoration()).copyWith(
                borderRadius: borderRadius,
                image: DecorationImage(image: imageProvider, fit: boxfit),
              ),
            )
          : null,
    );
  } else {
    image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: boxfit,
      cacheWidth: mWidth,
      cacheHeight: mHeight,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          decoration: (decoration ?? const BoxDecoration()).copyWith(
            color: AppPalette.hint.withValues(alpha: 0.1),
            borderRadius: borderRadius,
          ),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 1.5,
              backgroundColor: AppPalette.white,
              color: AppPalette.button,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          _buildErrorWidget(context, width, height, borderRadius, decoration),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || borderRadius == null) return child;
        return Container(
          width: width,
          height: height,
          decoration: (decoration ?? const BoxDecoration()).copyWith(
            borderRadius: borderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: child,
        );
      },
    );
  }

  if (aspectRatio != null) {
    return AspectRatio(aspectRatio: aspectRatio, child: image);
  }

  return image;
}

Widget _buildErrorWidget(
  BuildContext context,
  double? width,
  double? height,
  BorderRadius? borderRadius,
  BoxDecoration? decoration,
) {
  return Container(
    width: width,
    height: height,
    decoration: (decoration ?? const BoxDecoration()).copyWith(
      color: AppPalette.hint,
      borderRadius: borderRadius,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.photo, size: 28, color: AppPalette.grey),
        Constant.height(4),
        Text(
          'Load failed',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: AppPalette.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
