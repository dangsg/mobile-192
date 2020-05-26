// import 'package:flutter/material.dart';


// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image:  AssetImage("assets/icons/image2.jpg"),
//           fit: BoxFit.cover,
//         )
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: Colors.transparent,
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(23),
//             child: ListView(
//               children: <Widget>[
//                 SizedBox(height: 200,),
//                 Form(
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
//                         child: TextFormField(
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.white
//                               )
//                             ),
//                             labelText: 'Username',
//                             labelStyle: TextStyle(fontSize: 15,
//                             color: Colors.white)
//                           ),
//                         ),
//                       ),
//                       TextFormField(
//                         obscureText: true,
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.white
//                               )
//                             ),
//                             labelText: 'Password',
//                             labelStyle: TextStyle(fontSize: 15,
//                             color: Colors.white)
//                           ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20,bottom: 5),
//                   child: Text('Forgot your password?',
//                   textAlign: TextAlign.right,
//                     style: TextStyle(
//                       fontFamily: 'SFUIDisplay',
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white
//                     ),
//                     ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: MaterialButton(
//                     onPressed: (){},
//                     child: Text('SIGN IN',
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontFamily: 'SFUIDisplay',
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white
//                     ),
//                     ),
//                     color: Color(0xffff2d55),
//                     elevation: 0,
//                     minWidth: 350,
//                     height: 60,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50)
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: MaterialButton(
//                     onPressed: (){},
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         Icon(Icons.ac_unit),
//                         Text('Sign up with facebook',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontFamily: 'SFUIDisplay'
//                         ),)
//                       ],
//                     ),
//                     color: Colors.transparent,
//                     elevation: 0,
//                     minWidth: 350,
//                     height: 60,
//                     textColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                       side: BorderSide(color: Colors.white)
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 30),
//                   child: Center(
//                     child: RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "Don't have an account?",
//                             style: TextStyle(
//                               fontFamily: 'SFUIDisplay',
//                               color: Colors.white,
//                               fontSize: 15,
//                             )
//                           ),
//                           TextSpan(
//                             text: "sign up",
//                             style: TextStyle(
//                               fontFamily: 'SFUIDisplay',
//                               color: Color(0xffff2d55),
//                               fontSize: 15,
//                             )
//                           )
//                         ]
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/login_bloc/login_bloc.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'loginform.dart';


class LoginPage extends StatelessWidget {
  
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}