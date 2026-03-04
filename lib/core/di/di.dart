import 'package:get_it/get_it.dart';
import 'package:videodownload/core/service/youtube_explode_service.dart';
import 'package:videodownload/src/data/repo/video_repo_impl.dart';
import 'package:videodownload/src/domain/repo/video_repo.dart';
import 'package:videodownload/src/domain/usecase/video_usecase.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/video_player_cubit/video_player_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<YoutubeExplodeService>(
    () => YoutubeExplodeService(),
  );

  // Repositories
  sl.registerLazySingleton<VideoRepository>(
    () => VideoRepositoryImpl(youtubeService: sl()),
  );

  // Usecases
  sl.registerLazySingleton<VideoUsecase>(
    () => VideoUsecase(videoRepository: sl()),
  );

  // Blocs
  sl.registerFactory(() => VideoAnalyseBloc(videoUsecase: sl()));
  sl.registerFactory(() => VideoPlayerCubit());
}
