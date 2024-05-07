import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m_health_app/utils/Extension.dart';
import 'package:m_health_app/utils/colors.dart';
import 'package:m_health_app/utils/utils.dart';
import 'package:m_health_app/widget/LoadingWidget.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
    this.title = 'Chewie Demo',
    required this.linkVideo,
  });
  final String linkVideo;
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _VideoScreenState();
  }
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    var linkVideo = Uri.parse(widget.linkVideo);
    _videoPlayerController = VideoPlayerController.networkUrl(linkVideo);

    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControls: true,
      allowFullScreen: true,
      allowedScreenSleep: true,
      allowPlaybackSpeedChanging: true,
      optionsTranslation: OptionsTranslation(playbackSpeedButtonText: "Helo"),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      showOptions: false,
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        await rotation(enabled: false);
      },
      child: Theme(
        data: ThemeData(
          platform: TargetPlatform.iOS,
        ),
        child: Scaffold(
          backgroundColor: HexColor('222222'),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: HexColor('222222'),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.clear_rounded,
                color: Colors.white,
              ),
            ),
          ),
          body: (_videoPlayerController.value.isInitialized &&
                  _chewieController != null)
              ? SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: _chewieController != null &&
                                  _chewieController!
                                      .videoPlayerController.value.isInitialized
                              ? Chewie(
                                  controller: _chewieController!,
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                )
              : LoadingWidget(),
        ),
      ),
    );
  }
}

class CustomMaterialControls extends MaterialControls {
  const CustomMaterialControls({
    Key? key,
    required bool showPlayButton,
  }) : super(key: key, showPlayButton: showPlayButton);
}
