// ignore_for_file: use_key_in_widget_constructors, duplicate_ignore, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'list_music.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  List musicList = [
    {
      'titlesong': "About Damn Time",
      'artist': "Lizzo",
      'coversong':
          "https://i.scdn.co/image/ab67616d0000b273b817e721691aff3d67f26c04",
      'music':
          "https://www.farloaded.com/wp-content/uploads/2022/04/About_damn_time_FarloadedCom_Lizzo.mp3",
    },
    {
      'titlesong': "Light Switch",
      'artist': "Charlie Puth",
      'coversong':
          "https://i.scdn.co/image/ab67616d00001e02c7c579c9b540f56584909d28",
      'music':
          "https://vmlbox.com/wp-content/uploads/2022/04/Charlie-Puth-Light-Switch-Vmlboxcom.mp3",
    },
  ];

  String currentPlayTitle = "";
  String currentPlayArtist = "";

  IconData btnIcon = Icons.play_arrow;

  Duration duration = new Duration();
  Duration positionDuration = new Duration();

  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  String currentPlaySong = "";
  void playMusic(String music) async {
    if (isPlaying && currentPlaySong != music) {
      audioPlayer.pause();
      int result = await audioPlayer.play(music);
      if (result == 1) {
        setState(() {
          currentPlaySong = music;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(music);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btnIcon = Icons.pause;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        positionDuration = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.search,
          color: Colors.black,
        ),
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search Artist",
            hintStyle: TextStyle(color: Colors.black45),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.black,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, int index) => listMusicTile(
                    onTap: () {
                      playMusic(musicList[index]['music']);
                      setState(() {
                        currentPlayTitle = musicList[index]['titlesong'];
                        currentPlayArtist = musicList[index]['artist'];
                      });
                    },
                    title: musicList[index]['titlesong'],
                    artist: musicList[index]['artist'],
                    cover: musicList[index]['coversong'],
                    iconPlay: Icon(Icons.pause),
                    iconResume: Icon(Icons.play_arrow),
                    isActive: isPlaying)),
          ),
          Container(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20),
            decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
              BoxShadow(color: Color(0x55212121), blurRadius: 8.0)
            ]),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Slider.adaptive(
                      value: positionDuration.inSeconds.toDouble(),
                      min: 0.0,
                      max: duration.inSeconds.toDouble(),
                      onChanged: (value) {}),
                  Text(currentPlayTitle,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    currentPlayArtist,
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous,
                            size: 40,
                          )),
                      IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                            setState(() {
                              btnIcon = Icons.play_arrow;
                              isPlaying = false;
                            });
                          } else {
                            audioPlayer.resume();
                            setState(() {
                              btnIcon = Icons.pause;
                              isPlaying = true;
                            });
                          }
                        },
                        icon: Icon(
                          btnIcon,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.skip_next,
                          size: 40,
                        ),
                      )
                    ],
                  )
                ]),
          )
        ],
      ),
    );
  }
}
