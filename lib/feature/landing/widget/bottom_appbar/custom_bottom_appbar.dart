import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/feature/landing/widget/bottom_appbar/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/textstyles.dart';

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
                child: BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, state) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Home button
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onTabChange(0);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: state.selectedIndex == 0
                                    ? blueOriginal
                                    : blueShade3,
                              ),
                              const SizedBox(height: 4),
                              CommonTextWidget(
                                text: 'Home',
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
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onTabChange(1);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart_sharp,
                                color: state.selectedIndex == 1
                                    ? blueOriginal
                                    : blueShade3,
                              ),
                              const SizedBox(height: 4),
                              CommonTextWidget(
                                text: 'My Funds',
                                style: f12w400(
                                  color: state.selectedIndex == 1
                                      ? blueOriginal
                                      : blueShade3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onTabChange(2);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list_alt,
                                color: state.selectedIndex == 2
                                    ? blueOriginal
                                    : blueShade3,
                              ),
                              const SizedBox(height: 4),
                              CommonTextWidget(
                                text: 'Transactions',
                                style: f12w400(
                                  color: state.selectedIndex == 2
                                      ? blueOriginal
                                      : blueShade3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Statements button
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            widget.onTabChange(3);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: state.selectedIndex == 3
                                    ? blueOriginal
                                    : blueShade3,
                              ),
                              const SizedBox(height: 4),
                              CommonTextWidget(
                                text: 'Profile',
                                style: f12w400(
                                  color: state.selectedIndex == 3
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
