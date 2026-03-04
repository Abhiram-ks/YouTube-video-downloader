part of 'progresser_cubit.dart';

@immutable
abstract class ProgresserState {}

final class ProgresserInitial extends ProgresserState {}

final class ButtonProgressStart extends ProgresserState {
  final String message;
  ButtonProgressStart({required this.message});
}
final class ButtonprogressStop  extends ProgresserState {}