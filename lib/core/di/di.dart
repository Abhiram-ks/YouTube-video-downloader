import 'package:get_it/get_it.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:videodownload/core/service/download_service.dart';
import 'package:videodownload/core/service/gallery_service.dart';
import 'package:videodownload/core/service/youtube_explode_service.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';
import 'package:videodownload/src/data/repo/download_repo_impl.dart';
import 'package:videodownload/src/data/repo/video_repo_impl.dart';
import 'package:videodownload/src/domain/repo/download_repo.dart';
import 'package:videodownload/src/domain/repo/video_repo.dart';
import 'package:videodownload/src/domain/usecase/download_usecase.dart';
import 'package:videodownload/src/domain/usecase/video_usecase.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/state/bloc/download_bloc/download_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/library_cubit/library_cubit.dart';
import 'package:videodownload/src/presentation/state/cubit/video_player_cubit/video_player_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Local Database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    DownloadedVideoModelSchema,
  ], directory: dir.path);
  sl.registerSingleton<Isar>(isar);

  // Services
  sl.registerLazySingleton<YoutubeExplodeService>(
    () => YoutubeExplodeService(),
  );
  sl.registerLazySingleton<GalleryService>(() => GalleryService());
  sl.registerLazySingleton<DownloadService>(
    () => DownloadService(isar: sl(), galleryService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(youtubeService: sl()),
  );
  sl.registerLazySingleton<DownloadRepository>(
    () => DownloadRepositoryImpl(downloadService: sl()),
  );

  // Usecases
  sl.registerLazySingleton<VideoUsecase>(
    () => VideoUsecase(videoRepository: sl()),
  );
  sl.registerLazySingleton<DownloadUseCase>(
    () => DownloadUseCase(downloadRepository: sl()),
  );

  // Blocs / Cubits
  sl.registerFactory(() => VideoAnalyseBloc(videoUsecase: sl()));
  sl.registerFactory(() => VideoPlayerCubit());
  sl.registerFactory(
    () => DownloadBloc(downloadUseCase: sl(), videoUseCase: sl()),
  );
  sl.registerFactory(() => LibraryCubit(sl()));
}
