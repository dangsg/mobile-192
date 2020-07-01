import 'package:MOVIES/data/repositoties/service.dart';
import 'package:MOVIES/screens/star_rating.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MOVIES/block/cast_and_crew_bloc/cast_bloc.dart';
import 'package:MOVIES/block/cast_and_crew_bloc/cast_event.dart';
import 'package:MOVIES/block/cast_and_crew_bloc/cast_state.dart';
import 'package:MOVIES/block/cast_and_crew_bloc/cast_state.dart';
import 'package:MOVIES/data/model/api_cast_model.dart';
import 'package:MOVIES/data/model/api_result_model.dart';
import 'package:MOVIES/data/model/genre.dart';
import 'package:MOVIES/screens/search.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Details extends StatefulWidget {
  final Results movies;

  Details(this.movies);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<String> geners = [];
 int rating = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("geners:${}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              Hero(
                tag: widget.movies.posterPath,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.57,
                  color: Color(0xFF333333),
                  child: kIsWeb
                      ? Image.network(
                          widget.movies.posterPath,
                          width: double.infinity,
                          fit: BoxFit.cover)
                      : CachedNetworkImage(
                          width: double.infinity,
                          imageUrl:
                              widget.movies.posterPath,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.57,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xFF000000).withOpacity(1),
                          Colors.transparent,
                        ],
                        stops: [
                          0.2,
                          0.4,
                        ]),
                  )),
              Positioned(
                top: 30,
                left: 16,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white24),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.movies.title,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07,
                      fontFamily: "Poppins-Bold",
                      color: Color(0xFFFBFBFB) //Color(0xFF5d59d8)
                      ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        genres(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text("Storyline",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.05)),
                        ),
                        Text(widget.movies.overview,
                            style: TextStyle(
                                color: Colors.white.withOpacity(.8),
                                fontFamily: "Poppins-Light",
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.038))
                                    ,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text("Evaluate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.05)),
                        ),
                        StarRating(
          onChanged: (index) {
            
            Service.uploadRating(30, widget.movies.id, index);
            

            setState(() {
              rating = index;
            });
          },
          value: rating,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget genres() {

      geners=widget.movies.genreIds.split("|");
    

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: getTextWidgets(context, geners),
    );
  }
}

Widget getTextWidgets(context, List<String> strings) {
  List<Widget> list = new List<Widget>();
  for (var i = 0; i < strings.length; i++) {
    list.add(Container(
      decoration: BoxDecoration(
          color: Color(0xFFee6969), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 13),
        child: new Text(
          strings[i],
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              fontSize: MediaQuery.of(context).size.width * 0.033,
              fontFamily: "Poppins-Light"),
        ),
      ),
    ));
  }
  return new Wrap(runSpacing: 8, spacing: 8, children: list);
}

