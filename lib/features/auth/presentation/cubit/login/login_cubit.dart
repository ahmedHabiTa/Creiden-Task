import 'package:creiden/core/widgets/show_toast.dart';
import 'package:creiden/features/auth/domain/usecases/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/login_response.dart';
import '../auto_login/auto_login_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.login}) : super(LoginInitial());

  final Login login;
  User? _user;
  User? get user => _user;

  set updateUser(User newUser) {
    _user = newUser;
    emit(LoginSuccess(user: user!));
    emit(LoginInitial());
  }

  Future<void> fLogin({
    required GlobalKey<FormState> formKey,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(LoginLoading());
      final failOrUser = await login(LoginParams(
        email: email,
        password: password,
      ));
      failOrUser.fold((fail) {
        String message = "Try again";
        if (fail is ServerFailure) message = fail.message;
        showToastError(message);
        emit(LoginError(message: message));
        emit(LoginInitial());
      }, (newUser) {
        AppNavigator.popToFrist(context: context);
        sl<AutoLoginCubit>().emitHasUser(user: newUser.data.user);
        emit(LoginSuccess(user: newUser.data.user));
      });
    }
  }
}
