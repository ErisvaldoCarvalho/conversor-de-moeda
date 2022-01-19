import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String request = "https://api.hgbrasil.com/finance?format=json&key=098dd66a";

void main(){
  Future<String> getTest() async{
    try{
      http.Response response = await http.get(Uri.parse(request), headers: {'Content-type': 'application/json; chrset=UTF-8',});
      return response.body;
    }
    catch(e){
      return e.toString();
    }
  }

  runApp(MaterialApp(
      home: Scaffold( body:  FutureBuilder<String>(
        future: getTest(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

          if (snapshot.hasData) {
            return Container(child: Text(snapshot.data));
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            return Column(
              children: const <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ],
            );
          }
        },
      ),)
  ));
}