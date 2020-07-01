import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/logout_bloc/logout_bloc.dart';
import 'package:MOVIES/block/logout_bloc/logout_event.dart';
import 'package:MOVIES/block/logout_bloc/logout_state.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DialogLogout extends StatefulWidget{
  @override
  DialogLogoutState createState() => DialogLogoutState();
}
class DialogLogoutState extends State<DialogLogout>{
  @override
  Widget build(BuildContext context) {

    return Container(

      child:
    BlocProvider(create: (context)=>LogoutBloc(authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
    child:Builder(builder: (BuildContext  context){
      return  
      BlocListener<LogoutBloc,LogoutState>(listener: (context,state){
        if (state is LogoutSuccess){
                                  Fluttertoast.showToast(
                          msg: "Logout success",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1);
          Navigator.pop(context);
        }
      },
      child:      AlertDialog(
          
            title: Text(
              "Đăng xuất",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            content: Text("Bạn thật sự muốn đăng xuất tài khoản này?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Bỏ qua')),
              FlatButton(
                onPressed: () async {
                  
                  BlocProvider.of<LogoutBloc>(context).add(LogoutButtonPressed());
                  // bool check = await logout();
                  // await SharedPreferencesHelper.setPic(-1);
                  // await SharedPreferencesHelper.setToken("");

                  // if (check) {
                  //   Fluttertoast.showToast(
                  //       msg: "Đã đăng xuất",
                  //       toastLength: Toast.LENGTH_SHORT,
                  //       timeInSecForIos: 1,
                  //       gravity: ToastGravity.CENTER);
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => LogInScreen()),
                    //     (Route<dynamic> route) => false);
                  // } else {
                  //   Navigator.pop(context);
                  // }
                },
                child: Text('Đăng xuất'),
              )
            ],
          ) 
      );


    },)
             
    
    ));
  }
}