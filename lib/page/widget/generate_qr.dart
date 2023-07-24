// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:multifunction_camera/widget/custom_appbar.dart';
import 'package:multifunction_camera/widget/custom_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
  const GenerateQR({Key? key}) : super(key: key);

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  TextEditingController? _controller;
  String? _qrCode;
  FocusNode? _focusNode = FocusNode();
  Uint8List? _image;
  GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode!.dispose();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: Text("Generate QR")),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              // QR Code
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(60),
                  alignment: Alignment.center,
                  child: QrImage(
                    backgroundColor: Color.fromARGB(0, 9, 8, 8),
                    version: QrVersions.auto,
                    data: _qrCode ?? 'please input qr content',
                    // embeddedImage: AssetImage(
                    //   'assets/logo/logo.png',
                    // ),
                    // embeddedImageStyle: QrEmbeddedImageStyle(
                    //   size: Size(53, 53),
                    // ),
                  ),
                ),
              ),
              // 按钮
              _inputAndBtnWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputAndBtnWidget() {
    return Column(
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            maxLines: 3,
            focusNode: _focusNode,
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'please input qr content',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrCode = _controller!.text;
                  EasyLoading.showToast("Generate Successfully!");
                });
              },
              child: Text("Generate"),
            ),
            SizedBox(width: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller!.text = '';
                  EasyLoading.showToast("Clear Successfully!");
                });
              },
              child: Text("Clear"),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _saveWidgetToPng();
            });
          },
          child: Text("Save"),
        ),
      ],
    );
  }

  // 将页面保存为图片
  _saveWidgetToPng() async {
    Uint8List? uint8list = await _widgetToPng();
    if (uint8list != null) {
      setState(() {
        _image = uint8list;
      });

      final dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/share_image.png');
      var path = await file.writeAsBytes(_image!);
      final result = await ImageGallerySaver.saveFile(path.path);
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _image = null;
        });
      });
      EasyLoading.showSuccess("Saved Successfully!");
    } else {
      EasyLoading.showError("Error!");
    }
  }

  Future<Uint8List?> _widgetToPng() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image =
        await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
    ByteData? byteData =
        await (image.toByteData(format: ui.ImageByteFormat.png));
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }
    return null;
  }
}
