import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videodownload/core/di/di.dart';
import 'package:videodownload/core/theme/app_palette.dart';
import 'package:videodownload/src/presentation/screen/home/home_screen.dart';
import 'package:videodownload/src/presentation/screen/library/library_screen.dart';
import 'package:videodownload/src/presentation/state/bloc/video_analyse_bloc/bloc/video_analyse_bloc.dart';
import 'package:videodownload/src/presentation/state/cubit/nav_cubit.dart';
import 'package:videodownload/src/presentation/state/cubit/progresser_cubit/progresser_cubit.dart';

const double bottomNavBarHeight = 70.0;

class BottomNavigationControllers extends StatelessWidget {
  final List<Widget> _screens = [HomeScreen(), LibraryScreen()];

  BottomNavigationControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ButtomNavCubit()),
        BlocProvider(create: (context) => ProgresserCubit()),
        BlocProvider(create: (context) => sl<VideoAnalyseBloc>()),
      ],
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: AppPalette.white.withAlpha((0.3 * 225).round()),
          highlightColor: AppPalette.button.withAlpha((0.2 * 255).round()),
        ),
        child: ColoredBox(
          color: AppPalette.blue.withValues(alpha: 1),
          child: SafeArea(
            child: Scaffold(
              body: BlocBuilder<ButtomNavCubit, NavItem>(
                builder: (context, state) {
                  return IndexedStack(
                    index: NavItem.values.indexOf(state),
                    children: _screens,
                  );
                },
              ),
              bottomNavigationBar: BlocBuilder<ButtomNavCubit, NavItem>(
                builder: (context, state) {
                  return SizedBox(
                    height: bottomNavBarHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppPalette.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppPalette.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: BottomNavigationBar(
                        enableFeedback: true,
                        useLegacyColorScheme: true,
                        elevation: 0,
                        iconSize: 26,
                        selectedItemColor: AppPalette.button,
                        backgroundColor: Colors.transparent,
                        landscapeLayout:
                            BottomNavigationBarLandscapeLayout.spread,
                        unselectedLabelStyle: TextStyle(color: AppPalette.hint),
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: NavItem.values.indexOf(state),
                        onTap: (index) {
                          context.read<ButtomNavCubit>().selectItem(
                            NavItem.values[index],
                          );
                        },
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined, size: 16),
                            label: 'Home',
                            activeIcon: Icon(
                              Icons.home,
                              color: AppPalette.button,
                            ),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.video_library_outlined, size: 16),
                            label: 'Library',
                            activeIcon: Icon(
                              Icons.video_library_rounded,
                              color: AppPalette.button,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
