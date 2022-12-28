import 'package:audio_player/MyHomePage.dart';
import 'package:audio_player/detail_audio_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Audio Reading',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

            primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
    );
  }
}

