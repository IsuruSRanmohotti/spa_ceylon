import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:spa_ceylon/providers/auth_provider.dart';
import 'package:spa_ceylon/utils/color_utils.dart';

import '../../components/buttons/custom_buton.dart';
import '../../components/text_fields/custom_textfield.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isSignIn = true;
  bool isForgotPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: ColorUtils.scaffoldColor,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Hero(
                          tag: 'logo',
                          child: SvgPicture.asset(
                            'assets/svg/logo.svg',
                            width: size.width * 0.8,
                            colorFilter: ColorFilter.mode(
                              Colors.amber,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        isForgotPassword
                            ? 'Forgot Password?'
                            : isSignIn
                            ? 'Sign In'
                            : 'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        isForgotPassword
                            ? 'Please enter your email'
                            : isSignIn
                            ? 'Please sign in to continue'
                            : 'Create an account to get started',
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 20),
                      if(!isSignIn && !isForgotPassword)
                      CustomTextField(
                        label: 'User Name',
                        prefixIcon: Icons.person,
                        controller: authProvider.userNameController,
                      ),
                  
                      CustomTextField(
                        label: 'Email',
                        prefixIcon: Icons.email,
                        controller: authProvider.emailController,
                      ),
                      if (!isForgotPassword)
                        CustomTextField(
                          label: 'Password',
                          prefixIcon: Icons.password,
                          isPassword: true,
                          controller: authProvider.passwordController,
                        ),
                      if (!isSignIn && !isForgotPassword)
                        CustomTextField(
                          label: 'Confirm Password',
                          prefixIcon: Icons.password,
                          isPassword: true,
                          controller: authProvider.confirmPasswordController,
                        ),
                      if (isSignIn && !isForgotPassword)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                isForgotPassword = true;
                              });
                            },
                            child: Text('Forgot Password?'),
                          ),
                        ),
                      SizedBox(height: 20),
                  
                      CustomButton(
                        text:
                            isForgotPassword
                                ? 'Send Reset Email'
                                : isSignIn
                                ? 'Sign In'
                                : 'Create Account',
                  
                        onTap: () {
                          if (isForgotPassword) {
                            authProvider.startSendPasswordResetEmail(context);
                          } else if (isSignIn) {
                            authProvider.startSignIn(context);
                          } else {
                            authProvider.startSignUp(context);
                          }
                        },
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Center(
                          child: Text(
                            isForgotPassword
                                ? 'Or'
                                : isSignIn
                                ? "Don't have an account ?"
                                : 'Already have an account ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      CustomButton(
                        onTap: () {
                          setState(() {
                            isSignIn = !isSignIn;
                            if (isForgotPassword) {
                              isSignIn = true;
                              isForgotPassword = false;
                            }
                          });
                        },
                        text:
                            isForgotPassword
                                ? 'Sign In'
                                : isSignIn
                                ? 'Create Account'
                                : 'Sign In',
                        bgColor: Colors.grey.shade800,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
