import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';
import 'package:videodownload/src/data/local/model/downloaded_video_model.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final Isar _isar;
  LibraryCubit(this._isar) : super(LibraryInitial()) {
    _watchVideos();
  }

  StreamSubscription? _videoSubscription;

  void _watchVideos() {
    _videoSubscription?.cancel();
    emit(LibraryLoading());
    _videoSubscription = _isar.downloadedVideoModels
        .where()
        .sortByDownloadedAtDesc()
        .watch(fireImmediately: true)
        .listen((videos) {
          emit(LibraryLoaded(videos));
        });
  }

  Future<void> refreshLibrary() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _watchVideos();
  }

  Future<void> deleteVideo(DownloadedVideoModel video) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.downloadedVideoModels.delete(video.id);
      });
      final file = File(video.filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      emit(LibraryError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _videoSubscription?.cancel();
    return super.close();
  }
}
