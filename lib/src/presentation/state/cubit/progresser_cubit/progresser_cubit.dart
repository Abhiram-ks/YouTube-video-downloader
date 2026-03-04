import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'progresser_state.dart';

class ProgresserCubit extends Cubit<ProgresserState> {
  ProgresserCubit() : super(ProgresserInitial());

    void startLoading({
      String? message,
    }) {
    emit(ButtonProgressStart(message: message ?? "Please Wait",));
  }

  void stopLoading() {
    emit(ButtonprogressStop());
  }
}