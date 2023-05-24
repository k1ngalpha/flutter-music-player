import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'song.dart';
import 'song_list.dart';

class SongPlayingPage extends StatefulWidget {
  @override
  _SongPlayingPageState createState() => _SongPlayingPageState();
}

class _SongPlayingPageState extends State<SongPlayingPage> {
  late AudioPlayer audioPlayer;
  late Song song;

  PlayerState playerState = PlayerState.stopped;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        this.duration = duration;
      });
    });
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        this.position = position;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void play() async {
    await audioPlayer.setSourceAsset(song.audioPath);
    await audioPlayer.resume();
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  void pause() async {
    await audioPlayer.pause();
    setState(() {
      playerState = PlayerState.paused;
    });
  }

  void stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  void skipToNextSong() {
    final currentIndex = SongListPage().songs.indexOf(song);
    final nextIndex = (currentIndex + 1) % SongListPage().songs.length;
    Navigator.pushReplacementNamed(context, '/song',
        arguments: SongListPage().songs[nextIndex]);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    song = ModalRoute.of(context)!.settings.arguments as Song;

    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              song.coverArtPath,
              width: 200,
              height: 200,
            ),
            Text(
              song.title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              song.artist,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDuration(position),
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                Text(
                  formatDuration(duration),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              max: duration.inSeconds.toDouble(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.play_circle_fill),
                  onPressed: playerState != PlayerState.playing ? play : null,
                ),
                IconButton(
                  icon: Icon(Icons.pause_circle_filled),
                  onPressed: playerState == PlayerState.playing ? pause : null,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: skipToNextSong,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
