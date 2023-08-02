import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecases.dart';
import '../../../../../injection_container.dart';
import '../../../domain/entities/login_response.dart';
import '../../../domain/usecases/auto_login.dart';
import '../login/login_cubit.dart';

part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  AutoLoginCubit({required this.autoLogin}) : super(AutoLoginInitial());
  final AutoLogin autoLogin;

  Future<void> fAutoLogin() async {
    emit(AutoLoginLoading());
    final failOrUser = await autoLogin(NoParams());
    failOrUser.fold((fail) {
      emit(AutoLoginNoUser());
    }, (user) {
      sl<LoginCubit>().updateUser = user;
      emit(AutoLoginHasUser(user: user));
    });
  }

  void emitLoading() {
    emit(AutoLoginLoading());
  }

  void emitHasUser({required User user}) {
    emit(AutoLoginInitial());
    emit(AutoLoginHasUser(user: user));
  }

  void emitSeenIntro() {
    emit(AutoLoginSeenIntro());
  }

  void emitNoUser() {
    emit(AutoLoginNoUser());
  }

  void emitGuestMode() {
    emit(AutoLoginGuestModeState());
  }
}
