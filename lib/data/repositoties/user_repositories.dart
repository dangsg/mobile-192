import 'package:MOVIES/data/repositoties/service.dart';
import 'package:MOVIES/share_pre/SharedPreferencesHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    try{
    dynamic result = await Service.login(username, password);
    if(result ==null){
      return null;
    }
    else{
      return result['token'];
    }
    }
    catch(e){


    }
  }

  Future<void> deleteToken() async {
   await SharedPreferencesHelper.setToken("");
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await SharedPreferencesHelper.setToken(token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
     String token = await SharedPreferencesHelper.getToken();
     if( token != null && token!=""){
       return true;
     }
    return false;
  }
}