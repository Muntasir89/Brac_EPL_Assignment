import 'package:branc_epl/core/common/widgets/common_input_field.dart';
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

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
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
                  showSnackBar(context, "Sign Up Successful");
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
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
                      Gap.h24,
                      // Title
                      CommonTextWidget(
                        text: 'Create Account',
                        style: f28w700(color: black),
                      ),
                      Gap.h8,
                      // Subtitle
                      CommonTextWidget(
                        text: 'Start managing your investments today',
                        style: f14w400(color: Color(0xFF6B7280)),
                      ),
                      Gap.h40,
                      // Full Name Field
                      CommonInputField(
                        controller: nameController,
                        title: 'Full Name',
                        hintText: 'John Doe',
                        inputType: TextInputType.name,
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
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),
                      Gap.h20,

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
                        hintText: 'Create a password',
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
                          color: Color(0xFF6B7280),
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
                      Gap.h20,

                      // Confirm Password Field
                      CommonInputField(
                        controller: confirmPasswordController,
                        title: 'Confirm Password',
                        hintText: 'Confirm your password',
                        obscureText: _obscureConfirmPassword,
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
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xFF6B7280),
                        ),
                        suffixIconAlwaysVisible: true,
                        onSuffixIconPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      Gap.h32,

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthSignUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
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
                            text: 'Sign Up',
                            style: f16w600(color: white),
                          ),
                        ),
                      ),
                      Gap.h24,

                      // Log In Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonTextWidget(
                            text: 'Already have an account? ',
                            style: f14w400(color: Color(0xFF6B7280)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: CommonTextWidget(
                              text: 'Log In',
                              style: f14w600(color: blueOriginal),
                            ),
                          ),
                        ],
                      ),
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
