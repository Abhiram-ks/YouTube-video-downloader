import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videodownload/core/common/custom_snackbar.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/progresser_cubit/progresser_cubit.dart';
import 'package:videodownload/src/presentation/widget/home/home_widget.dart';

import '../../../../core/theme/app_palette.dart';

void homeStateHanlde({
  required BuildContext context,
  required VideoAnalyseState state,
  required TextEditingController urlController,
}) {
  if (state is VideoAnalyseLoading) {
    context.read<ProgresserCubit>().startLoading(message: "Processing...");
  } else if (state is VideoAnalyseSuccess) {
    context.read<ProgresserCubit>().stopLoading();
    urlController.clear();
    showVideoDetails(context: context, video: state.videoDetails);
  } else if (state is VideoAnalyseFailure) {
    context.read<ProgresserCubit>().stopLoading();
    CustomSnackBar.show(
      context,
      message: state.error,
      backgroundColor: AppPalette.brickRed,
      textColor: AppPalette.white,
    );
  }
}
