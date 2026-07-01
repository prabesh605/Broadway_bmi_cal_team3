import 'package:broadway_bmi_cal/bloc/login_bloc/login_event.dart';
import 'package:broadway_bmi_cal/bloc/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(LoginLoading());
      event.email;
      event.password;
      await Future.delayed(Duration(seconds: 3));
      if (event.email == 'prabesh@gmail.com' && event.password == '123456') {
        emit(Success());
      } else {
        emit(LoginError(''));
      }
    });
    on<SignUp>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 3));
      // if(event.name==""||event.email==''||event.password==''){

      // }
      if (event.email == '') {
        emit(LoginError('Email cannot be empty'));
      } else if (event.name == '') {
        emit(LoginError("Name cannot be empty"));
      } else if (event.password == '') {
        emit(LoginError("Password cannot be empty"));
      } else {
        emit(SignUpSuccess(event.email, event.name));
      }
    });
    on<Logout>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(Duration(seconds: 3));
      emit(LogoutState());
    });
  }
}
