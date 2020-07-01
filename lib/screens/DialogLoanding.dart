import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogLoading extends StatefulWidget{
  final String text;

  DialogLoading({this.text});
  @override
  DialogLoadingState createState() => DialogLoadingState();
}
class DialogLoadingState extends State<DialogLoading>{

  @override
  Widget build(BuildContext context) {

    
      return  
SimpleDialog(
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text(widget.text,style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]) ;

  }
}