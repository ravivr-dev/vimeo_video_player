import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Used to notify that video is loaded or not
  bool isVideoLoading = true;

  /// Controller of the WebView
  InAppWebViewController? webViewController;

  @override
  void dispose() {
    super.dispose();
    webViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            VimeoVideoPlayer(
              videoId: "https://player.vimeo.com/external/116952736.sd.mp4?s=6fafed300f76bae9f2c1bdb97f2e3f4f&oauth2_token_id=55382050",
              isAutoPlay: true,
              onInAppWebViewCreated: (controller) {
                webViewController = controller;
              },
              onInAppWebViewLoadStart: (controller, url) {
                setState(() {
                  isVideoLoading = true;
                });
              },
              onInAppWebViewLoadStop: (controller, url) {
                setState(() {
                  isVideoLoading = false;
                });
              },
            ),
            if (isVideoLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
