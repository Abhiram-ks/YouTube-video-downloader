
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/debouncer/debouncer.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/widget/home/home_bloc_builder.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    super.key,
    required TextEditingController urlController,
    required Debouncer debouncer,
  }) : _urlController = urlController, _debouncer = debouncer;

  final TextEditingController _urlController;
  final Debouncer _debouncer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: HomeBlocBuilderWidget(urlController: _urlController, debouncer: _debouncer),
    );
  }
}