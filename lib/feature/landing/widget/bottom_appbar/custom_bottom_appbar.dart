import 'package:branc_epl/feature/landing/widget/bottom_appbar/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';

final indexProvider = StateProvider<int>((ref) => 0);

class CustomBottomAppBar extends ConsumerStatefulWidget {
  const CustomBottomAppBar({super.key, required this.onTabChange});

  final Function(int) onTabChange;

  @override
  ConsumerState<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends ConsumerState<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: transparentColor,
        highlightColor: transparentColor,
        scaffoldBackgroundColor: transparentColor,
        bottomAppBarTheme: BottomAppBarThemeData(color: transparentColor),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: white,
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              return Container(
                height: 60,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ref.read(indexProvider.notifier).update((_) => 0);
                          widget.onTabChange(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home),
                            const SizedBox(height: 4),
                            Text(
                              'Home',
                              style: f12w400(
                                color: state.selectedIndex == 0
                                    ? blueOriginal
                                    : blueShade3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Center space for FAB
                    const Expanded(child: SizedBox()),
                    // Statements button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ref.read(indexProvider.notifier).update((_) => 2);
                          widget.onTabChange(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home),
                            const SizedBox(height: 4),
                            Text(
                              'Home',
                              style: f12w400(
                                color: state.selectedIndex == 0
                                    ? blueOriginal
                                    : blueShade3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
