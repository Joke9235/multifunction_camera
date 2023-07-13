import 'package:flutter/material.dart';
import 'package:multifunction_camera/widget/custom_appbar.dart';
import 'package:multifunction_camera/widget/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _webViewController;
  String _title = '';
  bool _isLoading = true; // 设置状态
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _title = '浏览网页';
  }

  @override
  Widget build(BuildContext context) {
    String route = ModalRoute.of(context)!.settings.arguments.toString();
    // if (route.contains(
    //     "http://192.168.200.186:8080/Epidemic_bar_system_war_exploded/qrCode/toScanning?time=")) {
    //   setState(() {
    //     // _showButton = true;
    //   });
    // }
    // //定时
    // const timeout = const Duration(seconds: 10);
    // Timer(timeout, () {
    //   //callback function
    //   Navigator.of(context).pop();
    // });
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Text(_title),
        elevation: 0,
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     padding: EdgeInsets.only(right: 15),
        //     onPressed: () {
        //       reloadWebView();
        //     },
        //     icon: Icon(Icons.refresh),
        //   )
        // ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            _showWeb(route),
            _showLoading(context),
          ],
        ),
      ),
    );
  }

  //webView
  _showWeb(String route) {
    return WebView(
      initialUrl: route,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (_controller) {
        _webViewController = _controller;
      },
      navigationDelegate: (NavigationRequest request) {
        setState(() {
          _isLoading = true; // 开始访问页面，更新状态
        });

        return NavigationDecision.navigate;
      },
      onPageFinished: (url) {
        _getTitle();
        setState(() {
          _isLoading = false; // 页面加载完成，更新状态
        });
      },
    );
  }

  //加载
  _showLoading(BuildContext context) {
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _reButton(context);
  }

  //返回扫描按钮
  _reButton(BuildContext context) {
    return _showButton
        ? Positioned(
            top: (MediaQuery.of(context).size.height / 2) + 50,
            child: RaisedButton(
              padding: EdgeInsets.only(left: 50, right: 50),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '确定',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : Container();
  }

  /// 获取当前加载页面的 title
  _getTitle() async {
    String? title = await _webViewController!.getTitle();
    setState(() {
      _title = title ?? '';
    });
  }

  //刷新网页
  void reloadWebView() {
    _webViewController?.reload();
  }
}
