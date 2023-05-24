import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song.dart';

class SongListPage extends StatelessWidget {
  final List<Song> songs = [
    Song(
      title: 'Song 1',
      artist: 'Artist 1',
      audioPath: 'audio/song1.mp3',
      coverArtPath: 'images/cover1.jpg',
    ),
    Song(
      title: 'Song 2',
      artist: 'Artist 2',
      audioPath: 'audio/song2.mp3',
      coverArtPath: '/images/cover2.jpg',
    ),
    Song(
      title: 'Song 3',
      artist: 'Artist 3',
      audioPath: 'assets/audio/song3.mp3',
      coverArtPath: 'images/cover3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song List'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              songs[index].coverArtPath,
              width: 50,
              height: 50,
            ),
            title: Text(songs[index].title),
            subtitle: Text(songs[index].artist),
            onTap: () {
              Navigator.pushNamed(context, '/song', arguments: songs[index]);
            },
          );
        },
      ),
    );
  }
}
