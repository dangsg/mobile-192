import 'dart:async';

import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_event.dart';
import 'package:MOVIES/block/logout_bloc/logout_event.dart';
import 'package:MOVIES/block/logout_bloc/logout_state.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';



class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthenticationBloc authenticationBloc;

  LogoutBloc({

    @required this.authenticationBloc,
  })  :
      assert(authenticationBloc != null);
  @override
  LogoutState get initialState => LogoutInitial();
  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async*{
    if (event is LogoutButtonPressed) {
      

      yield LogoutLoading();

      try {
        
        authenticationBloc.add(LoggedOut());
        yield LogoutSuccess();
      } catch (error) {
        yield LogoutFailure(error: error.toString());
      }
    }
    
  }


  

  // @override
  // Stream<LoguotS> mapEventToState(LoginEvent event) async* {
  //   if (event is LoginButtonPressed) {
  //     yield LoginLoading();

  //     try {
  //       final token = await userRepository.authenticate(
  //         username: event.username,
  //         password: event.password,
  //       );
       

  //       authenticationBloc.add(LoggedOut());
  //       yield ();
  //     } catch (error) {
  //       yield LoginFailure(error: error.toString());
  //     }
  //   }
  // }
}