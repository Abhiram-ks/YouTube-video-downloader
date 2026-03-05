part of 'library_cubit.dart';


sealed class LibraryState extends Equatable {
  const LibraryState();
  @override
  List<Object?> get props => [];
}

final class LibraryInitial extends LibraryState {}

final class LibraryLoading extends LibraryState {}

final class LibraryLoaded extends LibraryState {
  final List<DownloadedVideoModel> videos;
  const LibraryLoaded(this.videos);
  @override
  List<Object?> get props => [videos];
}

final class LibraryError extends LibraryState {
  final String message;
  const LibraryError(this.message);
  @override
  List<Object?> get props => [message];
}
