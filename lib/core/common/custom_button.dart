
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/theme/app_palette.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color textColor;
  final double borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final double fontSize;
  final FontWeight fontWeight;
  final String? loadingText;
  final double? width;
  final double? height;
  final IconData? icon;
  final String? iconAsset;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppPalette.button,
    this.textColor = AppPalette.white,
    this.borderRadius = 8,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(vertical: 1),
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.loadingText,
    this.width,
    this.height,
    this.icon,
    this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: BlocBuilder<ProgresserCubit, ProgresserState>(
        builder: (context, state) {
          final bool isLoading = state is ButtonProgressStart;

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              disabledBackgroundColor: AppPalette.white.withValues(alpha: 0.5),
              elevation: .3,
              padding: padding,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius.r),
                side: borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
              ),
            ),
            onPressed:isLoading ? null : onPressed,
            child: Center(
              child: isLoading
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15.w,
                          height: 15.w,
                          child: CircularProgressIndicator(
                            color: textColor,
                            strokeWidth: 2.5,
                          ),
                        ),
                        Constant.width(8),
                        if (loadingText != null)
                          Text(
                            state.message,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(color: textColor),
                          ),
                      ],
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize.sp,
                        fontWeight: fontWeight,
                        color: textColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
            ),
          );
        },
      ),
    );
  }
}
