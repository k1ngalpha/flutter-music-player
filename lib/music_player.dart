import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song_list.dart';
import 'song_playing_page.dart';

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
      home: SongListPage(),
      routes: {
        '/song': (context) => SongPlayingPage(),
      },
    );
  }
}
