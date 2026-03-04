
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/theme/app_palette.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final IconData? prefixIcon;
  final bool isPasswordField;
  final TextEditingController? controller;
  final String? Function(String? value)? validate;
  final bool enabled;
  final Color? borderClr;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? fillClr;
  final ValueChanged<String>? onChanged;
  final double? borderRadius;
  final int? minLines;
  final int? maxLines;
  final Widget? suffix;
  final String? initialValue;
  final String? hintText;
  final VoidCallback? onTap;
  final bool readOnly;
  final double? suffixIconSize;
  final String? iconAssets;
  final String? iconAssetsLabelText;
  final bool isBorder;
  final Color? hintColor;
  final Color? labelColor;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.isPasswordField = false,
    this.controller,
    this.validate,
    this.enabled = true,
    this.borderClr,
    this.fillClr,
    this.onChanged,
    this.suffixWidget,
    this.borderRadius = 8,
    this.minLines = 1,
    this.maxLines = 1,
    this.suffix,
    this.initialValue,
    this.hintText,
    this.prefixWidget,
    this.onTap,
    this.suffixIconSize = 20,
    this.readOnly = false,
    this.iconAssets,
    this.iconAssetsLabelText,
    this.isBorder = true,
    this.hintColor,
    this.labelColor,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      validator: validate,
      textInputAction: textInputAction,
      readOnly: readOnly,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isPasswordField,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(height: 1.75, fontWeight: .w400),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: isPasswordField ? 1 : maxLines,

      decoration: InputDecoration(
        isDense: true,
        contentPadding:  EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 11.w,
        ),
        hintText: hintText,
        labelText: labelText,
        filled: fillClr != null,
        fillColor: fillClr,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: hintColor ?? AppPalette.grey.withValues(alpha: 0.6),
          height: 1.8,
        ),
        labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: labelColor ?? AppPalette.grey.withValues(alpha: 0.6),
          height: 1.8,
        ),
        prefixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        prefixIcon: prefixWidget,
        suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        suffixIcon:suffixWidget,
        enabledBorder: isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5.00),
                borderSide: BorderSide(
                  color: borderClr ?? AppPalette.white,
                  width: 1,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderClr ?? AppPalette.white,
                  width: 1,
                ),
              ),
        focusedBorder: isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5.00),
                borderSide: BorderSide(
                  color: borderClr ?? AppPalette.white,
                  width: 1,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: borderClr ?? AppPalette.white,
                  width: 1,
                ),
              ),
        errorBorder: isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5.00),
                borderSide: BorderSide(
                  color: AppPalette.brickRed.withValues(alpha: .5),
                  width: 1,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppPalette.brickRed.withValues(alpha: .5),
                  width: 1,
                ),
              ),
        focusedErrorBorder: isBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5.00),
                borderSide: BorderSide(
                  color: AppPalette.brickRed.withValues(alpha: .5),
                  width: 1,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppPalette.brickRed.withValues(alpha: .5),
                  width: 1,
                ),
              ),
      ),
    );
  }
}
