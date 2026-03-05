import 'dart:io';
import 'package:gal/gal.dart';

class GalleryService {
  Future<void> saveVideo(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('Video file not found at local storage');
    }

    bool hasAccess = await Gal.hasAccess();
    if (!hasAccess) {
      hasAccess = await Gal.requestAccess();
    }

    if (!hasAccess) {
      throw Exception(
        'Permission to access gallery was denied. Please enable it in settings.',
      );
    }

    // 2. Save the video
    try {
      await Gal.putVideo(path);
    } on GalException catch (e) {
      throw _handleGalException(e);
    } catch (e) {
      throw Exception(
        'An unexpected error occurred while saving to gallery: $e',
      );
    }
  }

  /// Maps GalException to user-friendly error messages
  Exception _handleGalException(GalException e) {
    switch (e.type) {
      case GalExceptionType.accessDenied:
        return Exception(
          'Gallery access denied. Please check your app permissions.',
        );
      case GalExceptionType.notEnoughSpace:
        return Exception('Not enough storage space to save the video.');
      case GalExceptionType.notSupportedFormat:
        return Exception('This video format is not supported by your gallery.');
      case GalExceptionType.unexpected:
      return Exception('An unexpected error occurred: ${e.toString()}');
    }
  }
}
