import 'dart:async';

import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_event.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_state.dart';
import 'package:MOVIES/block/login_bloc/login_event.dart';
import 'package:MOVIES/block/login_bloc/login_state.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      
      yield LoginLoading();
      if(event.username.isEmpty || event.password.isEmpty){
                              Fluttertoast.showToast(
                          msg: " username or password are not empty",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1);
                     yield LoginInitial();
                          return;
      }

    
      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
      
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
    if(event is SignUpButton){
      
       authenticationBloc.add(Register());
    }
  }
}