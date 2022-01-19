  import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
  import 'package:http/http.dart' as http;
  import 'dart:async';
  import 'dart:convert';

  const String request = "https://api.hgbrasil.com/finance?format=json&key=098dd66a";

  void main(){
    Future<Map> getData() async{
      try{
        http.Response response = await http.get(Uri.parse(request), headers: {'Content-type': 'application/json; chrset=UTF-8',});
        return json.decode(response.body);
      }
      catch(e){
        return e;
      }
    }

    runApp(MaterialApp(
        home: Home(),
        ));
  }
  
  class Home extends StatefulWidget {
    @override
    _HomeState createState() => _HomeState();
  }
  
  class _HomeState extends State<Home> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$Conversor\$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snepshot){
            switch(snepshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando dados...",
                  style: TextStyle(color: Colors.amber,
                  fontSize: 25.0,),
                  textAlign: TextAlign.center,),
                );
            }
          })
      );
    }
  }
  