import 'package:branc_epl/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/core/common/widgets/loader.dart';
import 'package:branc_epl/core/utils/show_snackbar.dart';
import 'package:branc_epl/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:branc_epl/feature/auth/presentation/pages/login_page.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/spacing.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Local state for user info
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    // Get current user info from AppUserCubit
    final userState = context.read<AppUserCubit>().state;
    if (userState is AppUserLoggedIn) {
      userName = userState.user.name;
      userEmail = userState.user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: frameBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: MultiBlocListener(
            listeners: [
              // Listen to AuthBloc for logout
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    showSnackBar(context, state.message);
                  } else if (state is AuthSuccess) {
                    showSnackBar(context, "Logout Successful");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
              // Listen to AppUserCubit for user info
              BlocListener<AppUserCubit, AppUserState>(
                listener: (context, state) {
                  if (state is AppUserLoggedIn) {
                    setState(() {
                      userName = state.user.name;
                      userEmail = state.user.email;
                    });
                  }
                },
              ),
            ],
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return Column(
                  children: [
                    Gap.h16,
                    // Title
                    CommonTextWidget(
                      text: 'Profile',
                      style: f20w600(color: black),
                    ),
                    Gap.h24,

                    // Profile Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: DimenSizes.radius_16,
                        boxShadow: [
                          BoxShadow(
                            color: black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Avatar
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: blueShade4,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: blueOriginal,
                            ),
                          ),
                          Gap.h16,

                          // Username
                          CommonTextWidget(
                            text: userName.isNotEmpty ? userName : 'User',
                            style: f20w600(color: black),
                          ),
                          Gap.h4,

                          // Email
                          CommonTextWidget(
                            text: userEmail.isNotEmpty
                                ? userEmail
                                : 'user@example.com',
                            style: f14w400(color: blackShade3),
                          ),
                        ],
                      ),
                    ),

                    Gap.h24,

                    // Settings Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget(
                            text: 'Settings',
                            style: f18w600(color: black),
                          ),
                          Gap.h12,

                          // Settings Items
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: DimenSizes.radius_12,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildSettingItem(
                                  icon: Icons.lock_outline,
                                  title: 'Security',
                                  onTap: () {},
                                ),
                                Divider(height: 1, color: blackShade5),
                                _buildSettingItem(
                                  icon: Icons.notifications_outlined,
                                  title: 'Notifications',
                                  onTap: () {},
                                ),
                                Divider(height: 1, color: blackShade5),
                                _buildSettingItem(
                                  icon: Icons.help_outline,
                                  title: 'Help & Support',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap.h24,

                    // About Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget(
                            text: 'About',
                            style: f18w600(color: black),
                          ),
                          Gap.h12,

                          // About Items
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: DimenSizes.radius_12,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildAboutItem(
                                  icon: Icons.info_outline,
                                  title: 'App Version',
                                  trailing: '1.0.0',
                                ),
                                Divider(height: 1, color: blackShade5),
                                _buildSettingItem(
                                  icon: Icons.description_outlined,
                                  title: 'Terms & Privacy',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap.h32,

                    // Log Out Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (context.mounted) {
                              context.read<AuthBloc>().add(AuthLogout());
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: redOriginal,
                            shape: RoundedRectangleBorder(
                              borderRadius: DimenSizes.radius_50,
                            ),
                            elevation: 0,
                          ),
                          child: CommonTextWidget(
                            text: 'Log Out',
                            style: f16w600(color: white),
                          ),
                        ),
                      ),
                    ),

                    Gap.h80, // Space for bottom nav
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: black),
            Gap.w16,
            Expanded(
              child: CommonTextWidget(
                text: title,
                style: f16w400(color: black),
              ),
            ),
            Icon(Icons.chevron_right, size: 24, color: blackShade3),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem({
    required IconData icon,
    required String title,
    required String trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 24, color: black),
          Gap.w16,
          Expanded(
            child: CommonTextWidget(
              text: title,
              style: f16w400(color: black),
            ),
          ),
          CommonTextWidget(
            text: trailing,
            style: f14w400(color: blackShade3),
          ),
        ],
      ),
    );
  }
}
