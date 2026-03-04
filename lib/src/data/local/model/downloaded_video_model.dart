import 'package:isar/isar.dart';

part 'downloaded_video_model.g.dart';

@collection
class DownloadedVideoModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String videoId;

  late String title;
  late String author;
  late String thumbnailUrl;
  late String logo;
  late int durationInSeconds;

  // Storage path of the downloaded file
  late String filePath;

  // Selected quality details
  late String qualityLabel;
  late int? sizeInBytes;

  @Index()
  late DateTime downloadedAt;

  late String status; // 'downloading', 'completed', 'failed'

  late int progress; // 0 to 100
}
