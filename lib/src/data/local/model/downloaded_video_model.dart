import 'package:isar_community/isar.dart';

part 'downloaded_video_model.g.dart';

enum DownloadStatus { processing, canceled, completed, retry }

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
  late String filePath;
  late String qualityLabel;
  late int? sizeInBytes;

  @Index()
  late DateTime downloadedAt;

  @enumerated
  late DownloadStatus status;

  late int progress;
}
