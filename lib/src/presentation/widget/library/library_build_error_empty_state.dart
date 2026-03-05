
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/common/custom_image_show.dart';
import 'package:videodownload/core/common/custom_shadow.dart';
import 'package:videodownload/core/constants/app_constant.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/state/cubit/library_cubit/library_cubit.dart';

Widget buildEmptyErrorState({
    required BuildContext context,
    required String title,
    required String subTitle,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Text(
            subTitle,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: AppPalette.grey),
            textAlign: TextAlign.center,
          ),
          Constant.height(6),
          Text(
            "Pull down or tap the icon to refresh.",
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppPalette.grey),
            textAlign: TextAlign.center,
          ),
          Constant.height(40),
          InkWell(
            onTap: () => context.read<LibraryCubit>().refreshLibrary(),
            borderRadius: BorderRadius.circular(100.r),
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: customBoxDecoration(borderRadius: 100),
              child: Icon(
                Icons.refresh_outlined,
                color: AppPalette.button,
                size: 28.sp,
              ),
            ),
          ),
          Constant.height(50),
          column(context: context),
        ],
      ),
    );
  }
