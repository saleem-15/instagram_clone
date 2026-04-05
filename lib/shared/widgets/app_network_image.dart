import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/services/image_cache_service.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/utils/logger.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Map<String, String>? httpHeaders;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.memCacheWidth,
    this.memCacheHeight,
    this.httpHeaders,
  });

  @override
  Widget build(BuildContext context) {
    // Device pixel ratio for high-density screens
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Calculate reasonable defaults for memCache sizes if not provided
    // This prevents decoding large images into high-resolution memory buffers
    final int? calculatedMemCacheWidth = memCacheWidth ??
        (width != null ? (width! * devicePixelRatio).round() : null);
    final int? calculatedMemCacheHeight = memCacheHeight ??
        (height != null ? (height! * devicePixelRatio).round() : null);

    return CachedNetworkImage(
      imageUrl: Api.normalizeUrl(imageUrl),
      width: width,
      height: height,
      fit: fit,
      httpHeaders: httpHeaders,
      cacheManager: ImageCacheService.imageManager,
      memCacheWidth: calculatedMemCacheWidth,
      memCacheHeight: calculatedMemCacheHeight,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Colors.grey.withValues(alpha: .1),
      ),
      errorWidget: (context, url, error) {
        AppLogger.error('Image error: $url', error, StackTrace.current);
        return Container(
          width: width,
          height: height,
          color: Colors.grey.withValues(alpha: .1),
          child: const Center(
            child: Icon(
              Icons.wifi_off_rounded,
              color: Colors.grey,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
