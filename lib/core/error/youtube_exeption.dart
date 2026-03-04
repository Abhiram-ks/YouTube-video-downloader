
class YoutubeServiceException implements Exception {
  final String message;
  final dynamic originalError;

  YoutubeServiceException(this.message, [this.originalError]);

  @override
  String toString() => message;
}
