import 'package:flutter/material.dart';

class ValidationHelper {
  static String? uriValidation({
    required BuildContext context,
    required String url,
  }) {
    if (url.isEmpty) {
      return 'The YouTube URL cannot be empty.';
    }

    final uri = Uri.tryParse(url);

    final bool isValid =
        uri != null &&
        uri.hasAbsolutePath &&
        uri.hasScheme &&
        uri.host.isNotEmpty;

    if (!isValid) {
      return "Please enter a valid URL";
    }

    return null;
  }
}
