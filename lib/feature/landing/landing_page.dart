import 'package:branc_epl/feature/home/view/home_page.dart';
import 'package:branc_epl/feature/landing/widget/bottom_appbar/bloc/navigation_bloc.dart';
import 'package:branc_epl/feature/landing/widget/bottom_appbar/custom_bottom_appbar.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static final screens = [
    HomePage(),
    Center(child: Text("My Funds")),
    Center(child: Text("Transaction History")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      // endDrawer: const CustomDrawerWidget(),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Stack(children: [screens[state.selectedIndex]]);
        },
      ),
      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          backgroundColor: redOriginal,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        onTabChange: (index) {
          context.read<NavigationBloc>().add(NavigationTabChanged(index));
        },
      ),
    );
  }
}
