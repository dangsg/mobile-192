
import 'dart:io';

import 'package:MOVIES/data/model/api_result_model.dart';
import 'package:MOVIES/share_pre/SharedPreferencesHelper.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';


final String urlLogin = "/mlogin/";

final String urlSignup = "/msignup/";
final String urlLogout = "/mlogout/";
final String domain = "http://172.17.20.235:8000";

class Service {
  ///define a dio instance and make a customOption and assign baseOption to instance
  static Dio _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
      );
      _dio = Dio(options);
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        print('onHttpClientCreate entered...');
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    return _dio;
  }

  static Future<dynamic> login(String username, String password) async {
   
    Map<String, String> param = {
      'username': username,
      'password': password,
    };
    try {
      final response = await getInstance().post("https://mymobileassigment.herokuapp.com/mlogin/",data: FormData.fromMap(param));
      
      if (response.statusCode == 200) {
        return response.data;
      }  else {
        return null;
      }
    } catch (e) {
      
              if(e.type == DioErrorType.RESPONSE){
                  
                Fluttertoast.showToast(
      msg:"username or password incorrect",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      gravity: ToastGravity.CENTER
    );
        }
      _checkError(e);
      throw Exception(e);
      
    }
  }
  static Future<List<Results>> getlistfilm(String type,int id) async {
   
    Map<String, String> param = {
      'type': type,
      'id': id.toString(),
    };
    var token = await SharedPreferencesHelper.getToken();
    print(token);
    getInstance().options.headers["Authorization"]="Token $token";
    try {

      final response = await getInstance().post("https://mymobileassigment.herokuapp.com/getlistfilm/",data: FormData.fromMap(param));
      
      if (response.statusCode == 200) {
        print(response.data);
      List<Results> movies = ApiResultModel.fromJson(response.data).results;
      return movies;
      }  
    } catch (e) {
        print(e);
        throw Exception(e);
      // _checkError(e);

    }
  }
  static Future<List<Results>> getSearch(String search) async {
   
    Map<String, String> param = {
      'search': search,

    };
    var token = await SharedPreferencesHelper.getToken();
    getInstance().options.headers["Authorization"]="Token $token";
    try {

      final response = await getInstance().post("https://mymobileassigment.herokuapp.com/searchmovie/",data: FormData.fromMap(param));
      
      if (response.statusCode == 200) {
        print(response.data);
      List<Results> movies = ApiResultModel.fromJson(response.data).results;
      return movies;
      }  
    } catch (e) {
        print(e);
        throw Exception(e);
      // _checkError(e);

    }
  }
  static Future<dynamic> signUp(String username, String password) async {

    Map<String, String> param = {
      'username': username,
      'password': password,
    };
    try {
      final response = await getInstance().post("https://mymobileassigment.herokuapp.com/msignup/",
          //headers: {"Content-Type": "application/json"},
          data: FormData.fromMap(param));
          print(response);
      if (response.statusCode == 200) {
        return response.data;
      }  else {
        return null;
      }
    } catch (e) {
      _checkError(e);
      return null;
    }
  }
  static Future<bool> logout()async{
    var token = await SharedPreferencesHelper.getToken();
    getInstance().options.headers["Authorization"]="Token $token";
    try{
    final response = await getInstance().get("https://mymobileassigment.herokuapp.com/mlogout/",);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    }
    catch(e){
      _checkError(e);
      
    }

  }
  static Future<dynamic> uploadRating(int iduser, int idmovie,int rating) async {

    Map<String, String> param = {
      'movie': iduser.toString(),
      'user': idmovie.toString(),
      'rating': rating.toString(),
    };
    var token = await SharedPreferencesHelper.getToken();
    getInstance().options.headers["Authorization"]="Token $token";
    try {
      final response = await getInstance().post("http://172.17.20.235:8000/uploadrating/",
          //headers: {"Content-Type": "application/json"},
          data: FormData.fromMap(param));
          print(response);
      if (response.statusCode == 200) {
        return response.data;
      }  else {
        return null;
      }
    } catch (e) {
      _checkError(e);
      
    }
  }
  static void _checkError(DioError error) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
              Fluttertoast.showToast(
      msg:"Error network connection",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      gravity: ToastGravity.CENTER
    );
        break;
      case DioErrorType.SEND_TIMEOUT:
              Fluttertoast.showToast(
      msg:"Error network connection",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      gravity: ToastGravity.CENTER
    );
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
              Fluttertoast.showToast(
      msg:"Error network connection",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      gravity: ToastGravity.CENTER
    );
        break;
      case DioErrorType.RESPONSE:
        print('The incoming Response is Invalid');
        break;
      case DioErrorType.CANCEL:
        print('Your Request Has Been Canceled');
        break;
      case DioErrorType.DEFAULT:
                      Fluttertoast.showToast(
      msg:"Error network connection",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIos: 1,
      gravity: ToastGravity.CENTER
    );
        break;
    }
  }

}
