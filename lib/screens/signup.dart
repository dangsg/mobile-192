import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_event.dart';
import 'package:MOVIES/block/signup_bloc/signup_bloc.dart';
import 'package:MOVIES/block/signup_bloc/signup_event.dart';
import 'package:MOVIES/block/signup_bloc/signup_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUp extends StatefulWidget{
  @override
  SignUpstate createState()=>SignUpstate();
  
}
class SignUpstate extends State<SignUp> {
    final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
        _onSignUpButtonPressed() {
      BlocProvider.of<SignUpBloc>(context).add(
        SignUpButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
          repassword: _repasswordController.text
        ),
      );
    }
    return 
    BlocProvider(create: (context)=>SignUpBloc(),
    child:
    SafeArea(
      child:
    Scaffold(
      body:
    Builder(builder: (BuildContext context){
      return 
     
    Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/image1.jpg'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
            )
          ),
        ),
        
        Center(
          child:
        SingleChildScrollView(child: 
        Container(
          width: MediaQuery.of(context).size.width,
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.8),
          ),
          child: Padding(
            padding: EdgeInsets.only(right:23,left:23,bottom: 23),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              
              children: <Widget>[
                Container(child: Text("Sign up",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w500),),
                
                
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      cursorRadius: Radius.circular(10),
                      controller: _usernameController,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                        
                        labelText: "Username",
                        prefixIcon: Icon(Icons.person_outline),
                        labelStyle: TextStyle(
                          fontSize: 15
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    controller: _passwordController
                    ,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(

                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: 
                Container(
                  color: Color(0xfff5f5f5),
                  child: TextFormField(
                    controller: _repasswordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(

                      labelText: 'Re-Password',
                      prefixIcon: Icon(Icons.refresh),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                ),),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: 
                  BlocListener<SignUpBloc,SignUpState>(listener: (context,state){
                    if(state is SignUpSuccess ){
                      Fluttertoast.showToast(
                          msg: "Đăng ký thành công",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1
                      ).then((onValue){
                        BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
      //                                               BlocProvider.of<SignUpBloc>(context).add(
      //   SignUpSuccessEvent(),
      // );
                      });

                    }
                    else if(state is SignUpFailure){
                      Fluttertoast.showToast(
                          msg: "Thông tin không hợp lệ",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1
                      );
                    }
                    
                  },
                  child:
                  MaterialButton(
                    onPressed: (){
                          BlocProvider.of<SignUpBloc>(context).add(
        SignUpButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text,
          repassword: _repasswordController.text
        ),
      );
                    },
                    //since this is only a UI app
                    child: Text('Sign Up',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    color: Color(0xffff2d55),
                    elevation: 0,
                    minWidth: 400,
                    height: 50,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),)


                ),
                                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Colors.white,
                              fontSize: 15,
                            )
                          ),
                         
                            
                          TextSpan(
                                              recognizer: new TapGestureRecognizer()
                    ..onTap = () { 
                      
                            BlocProvider.of<AuthenticationBloc>(context).add(Login()
        
      );
                  },
                            text: " Login",
                            style: TextStyle(
                              fontFamily: 'SFUIDisplay',
                              color: Color(0xffff2d55),
                              fontSize: 15,
                            )
                            
                          )
                          
                        ]
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        )))
      ],
    );})
    )));
  }
}