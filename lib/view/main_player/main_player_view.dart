  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:music_player/common_widget/player_bottom_button.dart';
  import 'package:music_player/view/main_player/driver_mode_view.dart';
  import 'package:sleek_circular_slider/sleek_circular_slider.dart';
  import 'package:music_player/models/song_model.dart';
  import '../../common/color_extension.dart';
  import 'package:audioplayers/audioplayers.dart';
  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'dart:async';

  class MainPlayerView extends StatefulWidget {

    final Song song;

    const MainPlayerView({Key? key, required this.song}) : super(key: key);

    @override
    State<MainPlayerView> createState() => _MainPlayerViewState();
  }

  class _MainPlayerViewState extends State<MainPlayerView> {
    AudioPlayer _audioPlayer = AudioPlayer();
    bool _isPlaying = false;
    Duration _currentPosition = Duration.zero;
    Duration _totalDuration = Duration.zero;

    List<Song> _songs = [];
    int _currentIndex = 0;
    bool _isLoading = true;

    @override
    void initState() {
      super.initState();
      _fetchSongs();
      _audioPlayer.onDurationChanged.listen((Duration duration) {
        setState(() {
          _totalDuration = duration;
        });
      });
      _audioPlayer.onPositionChanged .listen((Duration position) {
        setState(() {
          _currentPosition = position;
        });
      });
    }

    Future<void> _fetchSongs() async {
      try {
        setState(() {
          _isLoading = true;
        });
        final response = await http.get(
          Uri.parse('https://thantrieu.com/resources/braniumapis/songs.json'),
        );
        if (response.statusCode == 200) {
          final bodycontent = utf8.decode(response.bodyBytes);
          var songWrapper = jsonDecode(bodycontent) as Map;
          var songList = songWrapper['songs'] as List;
          List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
          setState(() {
            _songs = songs;
            _isLoading = false;
            _playSpecificSong(widget.song);
          });
        } else {
          print('Error fetching songs: ${response.statusCode}');
          setState(() {
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Error fetching songs: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
    void _playSpecificSong(Song song) {
      int index = _songs.indexWhere((s) => s.id == song.id);
      if (index != -1) {
        _currentIndex = index;
        _playMusic();
      }
    }
    void _playMusic() async {
      await _audioPlayer.play(UrlSource(_songs[_currentIndex].source));
      setState(() {
        _isPlaying = true;
        _currentPosition = Duration.zero;
      });
    }

    void _pauseMusic() async {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    }

    void _nextSong() {
      if (_currentIndex < _songs.length - 1) {
        setState(() {
          _currentIndex++;
          _currentPosition = Duration.zero; // Reset position when changing song
        });
        _playMusic();
      }
    }

    void _previousSong() {
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
          _currentPosition = Duration.zero; // Reset position when changing song
        });
        _playMusic();
      }
    }

    @override
    void dispose() {
      _audioPlayer.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      var media = MediaQuery.of(context).size;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: TColor.bg,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              "assets/img/back.png",
              width: 25,
              height: 25,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            "Now Playing",
            style: TextStyle(
              color: TColor.primaryText80,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            PopupMenuButton<int>(
              color: const Color(0xff383B49),
              offset: const Offset(-10, 15),
              elevation: 1,
              icon: Image.asset(
                "assets/img/more_btn.png",
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
              onSelected: (selectIndex) {
                if (selectIndex == 9) {
                  Get.to(() => const DriverModeView());
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 3,
                    height: 30,
                    child: Text(
                      "Add to playlist...",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(media.width * 0.7),
                    child: Image.network(
                      _songs.isNotEmpty ? _songs[_currentIndex].image : '',
                      width: media.width * 0.6,
                      height: media.width * 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: media.width * 0.6,
                    height: media.width * 0.6,
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          trackWidth: 4,
                          progressBarWidth: 6,
                          shadowWidth: 8,
                        ),
                        customColors: CustomSliderColors(
                          dotColor: const Color(0xffFFB1B2),
                          trackColor: const Color(0xffffffff).withOpacity(0.3),
                          progressBarColors: [
                            const  Color(0xffFB9967),
                            const Color(0xffE9585A)
                          ],
                          shadowColor: const Color(0xffFFB1B2),
                          shadowMaxOpacity: 0.05,
                        ),
                        infoProperties: InfoProperties(
                          topLabelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          topLabelText: 'Elapsed',
                          bottomLabelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          bottomLabelText: 'time',
                          mainLabelStyle: const TextStyle(
                            color: Colors.transparent,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        startAngle: 270,
                        angleRange: 360,
                        size: 350.0,
                      ),
                      min: 0,
                      max:  _totalDuration.inSeconds.toDouble(),
                      initialValue: _currentPosition.inSeconds.toDouble(),
                      onChange: (double value) async {
                        await _audioPlayer.seek(Duration(seconds: value.toInt()));
                      },
                      onChangeStart: (double startValue) {
                        // callback providing a starting value (when a pan gesture starts)
                      },
                      onChangeEnd: (double endValue) {
                        // ucallback providing an ending value (when a pan gesture ends)
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${_currentPosition.toString().split('.').first} | ${_totalDuration.toString().split('.').first}",
                style: TextStyle(color: TColor.secondaryText, fontSize: 12),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                _songs.isNotEmpty ? _songs[_currentIndex].title : "",
                style: TextStyle(
                  color: TColor.primaryText.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _songs.isNotEmpty
                    ? "${_songs[_currentIndex].artist} • Album - ${_songs[_currentIndex].album}"
                    : "",
                style: TextStyle(color: TColor.secondaryText, fontSize: 12),
              ),

              const SizedBox(
                height: 20,
              ),
              Slider(
                value: _currentPosition.inSeconds.toDouble(),
                max: _totalDuration.inSeconds.toDouble(),
                onChanged: (value) async {
                  await _audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              ),
              Text(
                "${_currentPosition.toString().split('.').first} | ${_totalDuration.toString().split('.').first}",
                style: TextStyle(color: TColor.secondaryText, fontSize: 12),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Divider(
                  color: Colors.white12,
                  height: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      onPressed: _previousSong,
                      icon: Image.asset(
                        "assets/img/previous_song.png",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      onPressed: () {
                        if (_isPlaying) {
                          _pauseMusic();
                        } else {
                          _playMusic();
                        }
                      },
                      icon: Image.asset(
                        _isPlaying ? "assets/img/pause.jpg" : "assets/img/play.png",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      onPressed: _nextSong,
                      icon: Image.asset(
                        "assets/img/next_song.png",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayerBottomButton(
                    title: "Playlist",
                    icon: "assets/img/playlist.png",
                    onPressed: () {},
                  ),
                  PlayerBottomButton(
                    title: "Shuffle",
                    icon: "assets/img/shuffle.png",
                    onPressed: () {},
                  ),
                  PlayerBottomButton(
                    title: "Repeat",
                    icon: "assets/img/repeat.png",
                    onPressed: () {},
                  ),
                  PlayerBottomButton(
                    title: "EQ",
                    icon: "assets/img/eq.png",
                    onPressed: () {},
                  ),
                  PlayerBottomButton(
                    title: "Favourites",
                    icon: "assets/img/fav.png",
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
