class VideoDetails {
  final String id;
  final String title;
  final String author;
  final String thumbnailUrl;
  final String logo;
  final Duration duration;
  final List<VideoQualityOption> qualityOptions;

  VideoDetails({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    required this.duration,
    required this.logo,
    required this.qualityOptions,
  });
}

class VideoQualityOption {
  final String qualityLabel;
  final String url;
  final int? sizeInBytes;

  VideoQualityOption({
    required this.qualityLabel,
    required this.url,
    this.sizeInBytes,
  });
}
