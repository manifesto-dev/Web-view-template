import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_app_template/business_logic/notification_repository.dart';
import 'package:web_app_template/constants/app_strings.dart';
import 'package:web_app_template/data/local/cache_helper.dart';
import 'package:web_app_template/presentation/styles/my_theme_data.dart';
import 'package:web_app_template/presentation/widget/loading_data_widget.dart';
import 'package:web_app_template/presentation/widget/no_internet.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  late dynamic token;
  int loadingPercentage = 0;
  String pullToRefreshJSCode = """
      var startY, endY, dist, threshold = 150, el = document.body;
      el.addEventListener('touchstart', function(e) {
        startY = e.touches[0].clientY;
      });
      el.addEventListener('touchmove', function(e) {
        endY = e.touches[0].clientY;
        dist = endY - startY;
        if (dist > threshold && window.pageYOffset === 0) {
          window.location.reload();
        }
      });
    """;
  String getTokenJSCode = """
      JSON.parse(localStorage.getItem('user')).token;
    """;
////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    permissionHandler();
    _controller = permissionSettings();
  }

  WebViewController permissionSettings() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..loadRequest(Uri.parse(AppStrings.webURL));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(true);
      (controller.platform as AndroidWebViewController)
          .setOnShowFileSelector(_androidFilePicker);
    }
    controller
        .setNavigationDelegate(NavigationDelegate(onPageFinished: (url) async {
      if (url == 'https://halajary.ae/' || url == 'https://halajary.ae/login') {
        token = await _controller.runJavaScriptReturningResult(getTokenJSCode);
        CacheHelper.saveDataSharedPreference(key: 'token', value: token);
        // await FirebaseApi().initNotifications();
      }

      _controller.runJavaScript(pullToRefreshJSCode);
      setState(() {
        loadingPercentage = 100;
        isLoading = false;
      });
    }, onPageStarted: (url) {
      setState(() {
        loadingPercentage = 0;
      });
    }, onProgress: (progress) {
      setState(() {
        loadingPercentage = progress;
      });
    }, onWebResourceError: (error) {
      debugPrint('----------------------------------------$error');
    }));
    return controller;
  }

  void permissionHandler() async {
    await [
      Permission.microphone,
      Permission.storage,
      Permission.locationWhenInUse,
      Permission.camera,
      Permission.notification
    ].request();
  }

  bool isCancel = true;
  Future<bool> _onWillPop() async {
    _controller.getScrollPosition().then((value) {
      setState(() {
        if (value.dy != 0.0) {
          _controller.scrollTo(0, 0);
          _controller.reload();
          isCancel = false;
        } else {
          isCancel = true;
        }
      });
    });
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    } else {
      if (isCancel == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  final GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: sKey,
        body: SafeArea(
          bottom: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark
                .copyWith(statusBarColor: MyThemeData.customPurple),
            child: OfflineBuilder(
              connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return Stack(
                    children: [
                      WebViewWidget(
                        controller: _controller,
                      ),
                      if (isLoading) const LoadingDataWidget(),
                      if (loadingPercentage < 100)
                        LinearProgressIndicator(
                          value: loadingPercentage / 100.0,
                        ),
                    ],
                  );
                } else {
                  return NoInternet(context: context);
                }
              },
              child: const LoadingDataWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> _androidFilePicker(
      webview_flutter_android.FileSelectorParams params) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'mp4', 'png'],
    );
    if (result == null) {
      return [];
    }
    var files = result.paths.map((path) => File(path!)).toList();
    return [files.first.uri.toString()];
  }
}
