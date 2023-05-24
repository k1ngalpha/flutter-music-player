import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'music_player.dart';
import 'song_list.dart';

void main() {
  runApp(MusicPlayerApp());
}

enum PlayerState { stopped, playing, paused }
