import 'dart:async';

import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_event.dart';
import 'package:MOVIES/block/login_bloc/login_event.dart';
import 'package:MOVIES/block/login_bloc/login_state.dart';
import 'package:MOVIES/block/signup_bloc/signup_event.dart';
import 'package:MOVIES/block/signup_bloc/signup_state.dart';
import 'package:MOVIES/data/repositoties/service.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // final UserRepository userRepository;
  // final AuthenticationBloc authenticationBloc;

  // LoginBloc({
  //   @required this.userRepository,
  //   @required this.authenticationBloc,
  // })  : assert(userRepository != null),
  //       assert(authenticationBloc != null);

  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpButtonPressed) {
      yield SignUpLoading();
        
    if(event.password.isNotEmpty && event.repassword.isNotEmpty && event.username.isNotEmpty && event.password.compareTo(event.repassword)==0){
            dynamic data=  await Service.signUp(event.username, event.password);
              if(data!=null && data['IsSuccess']==1){
                yield SignUpSuccess();
              }
              else{
                yield SignUpFailure(error:"Tên đăng nhập hoặc mật khẩu không đúng");
              }
    }
    else{
      yield SignUpFailure(error:"Thông tin đăng ký không hợp lệ");
    }

    

      // try {
      //   final token = await userRepository.authenticate(
      //     username: event.username,
      //     password: event.password,
      //   );

      //   authenticationBloc.add(LoggedIn(token: token));
      //   yield LoginInitial();
      // } catch (error) {
      //   yield LoginFailure(error: error.toString());
      // }
    }
  }
}