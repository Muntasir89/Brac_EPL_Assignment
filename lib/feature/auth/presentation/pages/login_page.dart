import 'package:branc_epl/core/common/widgets/common_input_field.dart';
import 'package:branc_epl/core/common/widgets/common_text_widget.dart';
import 'package:branc_epl/core/common/widgets/loader.dart';
import 'package:branc_epl/core/utils/show_snackbar.dart';
import 'package:branc_epl/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:branc_epl/feature/auth/presentation/pages/signup_page.dart';
import 'package:branc_epl/feature/landing/landing_page.dart';
import 'package:branc_epl/styles/colors.dart';
import 'package:branc_epl/styles/spacing.dart';
import 'package:branc_epl/styles/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LandingPage(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Log
                      Gap.h24,
                      // Title
                      CommonTextWidget(
                        text: 'Brack EPL',
                        style: f28w700(color: black),
                      ),
                      Gap.h8,

                      // Subtitle
                      CommonTextWidget(
                        text: 'Grow Your Investments',
                        style: f14w400(color: Color(0xFF89919E)),
                      ),
                      Gap.h40,

                      // Email Field
                      CommonInputField(
                        controller: emailController,
                        title: 'Email',
                        hintText: 'your.email@example.com',
                        inputType: TextInputType.emailAddress,
                        backgroundColor: frameBg,
                        borderRadius: DimenSizes.radius_12,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: DimenSizes.radius_12,
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: DimenSizes.radius_12,
                          borderSide: BorderSide(color: blueOriginal, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: DimenSizes.radius_12,
                          borderSide: BorderSide.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      Gap.h20,

                      // Password Field
                      CommonInputField(
                        controller: passwordController,
                        title: 'Password',
                        hintText: 'Enter your password',
                        obscureText: _obscurePassword,
                        backgroundColor: frameBg,
                        borderRadius: DimenSizes.radius_12,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: DimenSizes.radius_12,
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: DimenSizes.radius_12,
                          borderSide: BorderSide(color: blueOriginal, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: DimenSizes.radius_12,
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: blackShade3,
                        ),
                        suffixIconAlwaysVisible: true,
                        onSuffixIconPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      Gap.h12,

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Handle forgot password
                          },
                          child: CommonTextWidget(
                            text: 'Forgot Password?',
                            style: f14w600(color: blueOriginal),
                          ),
                        ),
                      ),
                      Gap.h32,

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthLogin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueOriginal,
                            shape: RoundedRectangleBorder(
                              borderRadius: DimenSizes.radius_50,
                            ),
                            elevation: 0,
                          ),
                          child: CommonTextWidget(
                            text: 'Log In',
                            style: f16w600(color: white),
                          ),
                        ),
                      ),
                      Gap.h24,

                      // Sign Up Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextWidget(
                            text: 'Don\'t have an account? ',
                            style: f14w400(color: blackShade3),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: CommonTextWidget(
                              text: 'Sign Up',
                              style: f14w600(color: blueOriginal),
                            ),
                          ),
                        ],
                      ),
                      Gap.h24,
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
