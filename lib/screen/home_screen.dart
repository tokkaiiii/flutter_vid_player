import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null
          ? _VideoPlayer(
              video: video!,
            )
          : _VideoSelector(
              onLogoTab: onLogoTab,
            ),
    );
  }

  void onLogoTab() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    setState(() {
      this.video = video;
    });
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTab;

  const _Logo({
    required this.onTab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTab;

  const _VideoSelector({
    required this.onLogoTab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTab: onLogoTab,
          ),
          SizedBox(height: 28.0),
          _Title(),
        ],
      ),
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;

  const _VideoPlayer({
    required this.video,
    super.key,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late final VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  initializeController() async {
    videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );
    await videoPlayerController.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Stack(
          children: [
            VideoPlayer(
              videoPlayerController,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(Icons.rotate_left),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: () {},
                    icon: Icon(Icons.rotate_right),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Slider(
                value: 0,
                onChanged: (double value){
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
