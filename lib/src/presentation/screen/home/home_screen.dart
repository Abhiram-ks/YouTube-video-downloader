import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:videodownload/core/debouncer/debouncer.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/widget/home/home_body_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _urlController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppPalette.blue,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "YouTube Save",
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
        body: HomeScreenBody(urlController: _urlController, debouncer: _debouncer),
      ),
    );
  }
}

