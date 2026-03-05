import 'package:flutter/material.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/widget/library/library_body_widget.dart';
import 'package:videodownload/src/presentation/widget/library/library_show_help_info.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.blue,
      appBar: AppBar(
        title: Text(
          "My Downloads",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppPalette.white,
            fontWeight: .bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const LibraryScreenBodyWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppPalette.button,
        shape: const CircleBorder(),
        onPressed: () {
          showHelpInfo(context);
        },
        child: const Icon(Icons.help_outline_sharp, color: AppPalette.white),
      ),
    );
  }
}


