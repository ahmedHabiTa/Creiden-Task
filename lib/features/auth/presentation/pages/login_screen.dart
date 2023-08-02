// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:creiden/core/util/validator.dart';
import 'package:creiden/core/widgets/loading.dart';
import 'package:creiden/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Login',
              style: TextStyles.textViewRegular20
                  .copyWith(color: mainColor, fontSize: 32),
            ),
          ),
          SizedBox(height: 70.h),
          Expanded(
            child: Form(
              key: formKey,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.1),
                        blurRadius: 12,
                        spreadRadius: 4,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          'Email *',
                          style: TextStyles.textViewMedium15
                              .copyWith(color: mainColor.withOpacity(0.7)),
                        ),
                        const SizedBox(height: 15),
                        MasterTextField(
                          controller: emailController,
                          validate: (value) => Validator.email(value),
                          hintText: 'Enter your email',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Password *',
                          style: TextStyles.textViewMedium15
                              .copyWith(color: mainColor.withOpacity(0.7)),
                        ),
                        const SizedBox(height: 15),
                        MasterTextField(
                          controller: passwordController,
                          validate: (value) =>
                              Validator.defaultValidator(value),
                          hintText: 'Enter your password',
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return const Loading();
                              }
                              return GestureDetector(
                                onTap: () {
                                  context.read<LoginCubit>().fLogin(
                                      formKey: formKey,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context);
                                },
                                child: Container(
                                  height: 46.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),
                                    gradient: LinearGradient(
                                      colors: buttomGradient,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Sign In',
                                    style: TextStyles.textViewRegular16
                                        .copyWith(color: white),
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MasterTextField extends StatelessWidget {
  final TextEditingController controller;

  final String? Function(String?) validate;
  final String hintText;
  const MasterTextField({
    Key? key,
    required this.controller,
    required this.validate,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: TextStyles.textViewRegular15
            .copyWith(color: Colors.grey.withOpacity(0.4)),
        fillColor: Colors.grey.withOpacity(0.1),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
