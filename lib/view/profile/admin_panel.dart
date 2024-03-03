import 'dart:io';
import 'package:alnsher/core/toasts.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key }
      ) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    AppToasts.toastLoading();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body:  WebView(
          onPageFinished: (url) {
            setState(() {
              AppToasts.hideLoading();
            });
          },
          initialUrl: 'https://alnsher.com/dashboard/login',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}