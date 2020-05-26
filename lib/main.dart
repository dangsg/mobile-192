import 'dart:async';

import 'package:MOVIES/block/authentication_bloc/authentication_bloc.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_event.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_state.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:MOVIES/screens/DialogLogout.dart';
import 'package:MOVIES/screens/Loading.dart';
import 'package:MOVIES/screens/login.dart';
import 'package:MOVIES/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MOVIES/block/cast_and_crew_bloc/cast_bloc.dart';
import 'package:MOVIES/block/movie_bloc/movie_bloc.dart';
import 'package:MOVIES/block/movie_bloc/movie_event.dart';
import 'package:MOVIES/block/movie_bloc/movie_state.dart';
import 'package:MOVIES/block/search_block/search_bloc.dart';
import 'package:MOVIES/data/repositoties/movie_repositories.dart';
import 'package:MOVIES/screens/home.dart';
import 'package:MOVIES/screens/network.dart';
import 'package:MOVIES/screens/search.dart';
import 'package:shimmer/shimmer.dart';



void main() {
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository,),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashScreen();
          }
          if (state is AuthenticationAuthenticated) {
            return MyApp();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          if (state is AuthenticationRegister){
            return SignUp();
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Review",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: "Poppins-Bold",
                  fontWeight: FontWeight.w600),
            ),

          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(repository: MovieRepositoryImpl()),
        ),
        BlocProvider<SearchMovieBloc>(
          create: (context) =>
              SearchMovieBloc(repository: MovieRepositoryImpl()),
        ),
        BlocProvider<CastBloc>(
          create: (context) => CastBloc(repository: MovieRepositoryImpl()),
        ),
      ],
      //create: (context) => MovieBloc(repository: MovieRepositoryImpl()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light),
            child: Scaffold(backgroundColor: Colors.black, body: MyHomePage()),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeIndex = 0;

  MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(FetchMovieEvent(movieType: "now_playing"));
    //movieBloc.add(FetchMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(width),
            tabBar(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child:
                  BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
                if (state is MovieInitialState) {
                  return loading();
                } else if (state is MovieLoadingState) {
                  return loading();
                } else if (state is MovieLoadedState) {
                  return Home(state.movies);
                } else if (state is MovieErrorState) {
                  return NetworkError();
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget appBar(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Row(
          children: <Widget>[
            Text(
              "Review",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.08,
                  fontFamily: "Poppins-Bold",
                  fontWeight: FontWeight.w600),
            ),

          ],
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.white,
          iconSize: width * 0.08,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return SearchScreen();
            }));
          },
        ),
        IconButton(
          icon: Icon(Icons.power_settings_new),
          color: Colors.white,
          iconSize: width * 0.08,
          onPressed: () {
                  showDialog(
                    context: context,
                    builder: (newContext){
                      return DialogLogout();
                    }
                  );
          },
        )
      ],
    );
  }

  Widget tabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          tab(0, "For You", "upcoming"),
          tab(1, "In Threaters", "now_playing"),
          tab(2, "Upcomings", "upcoming"),
          tab(3, "Popular", "popular"),
        ],
      ),
    );
  }

  Widget tab(int index, String title, String movieType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
      child: InkWell(
        onTap: () {
          movieBloc.add(FetchMovieEvent(movieType: movieType));
          setState(() {
            activeIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:
                  activeIndex == index ? Colors.redAccent : Color(0xFF333333)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins-Light",
                color: activeIndex == index ? Colors.white : Color(0xFF999999),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget loading() {
  int offset = 0;
  int time;
  return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        offset += 10;
        time = 800 + offset;
        return Shimmer.fromColors(
          period: Duration(milliseconds: time),
          highlightColor: Color(0xFF1a1c20),
          baseColor: Color(0xFF111111),
          child: Container(
            margin: EdgeInsets.all(4.0),
            height: MediaQuery.of(context).size.height * 0.19,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF333333),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 0,
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: MediaQuery.of(context).size.height * 0.16,
                  child: Container(
                    width: 145,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: Color(0xFF333333),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
