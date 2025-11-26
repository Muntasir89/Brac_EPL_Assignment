import 'package:branc_epl/feature/home/view/home_page.dart';
import 'package:branc_epl/feature/landing/widget/bottom_appbar/bloc/navigation_bloc.dart';
import 'package:branc_epl/feature/landing/widget/bottom_appbar/custom_bottom_appbar.dart';
import 'package:branc_epl/feature/my_funds/view/my_funds_page.dart';
import 'package:branc_epl/feature/profile/view/profile_page.dart';
import 'package:branc_epl/feature/transaction_history/view/transaction_history_page.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static final screens = [
    HomePage(),
    MyFundsPage(),
    TransactionHistoryPage(),
    ProfilePage(),
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
      bottomNavigationBar: CustomBottomAppBar(
        onTabChange: (index) {
          context.read<NavigationBloc>().add(NavigationTabChanged(index));
        },
      ),
    );
  }
}
