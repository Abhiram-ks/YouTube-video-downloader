
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // // Repositories
  // sl.registerLazySingleton<VideoRepository>(() => VideoRepositoryImpl());

  // // Blocs
  // sl.registerFactory(() => VideoAnalysisBloc(videoRepository: sl()));
}
