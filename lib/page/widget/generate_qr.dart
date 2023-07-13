import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multifunction_camera/widget/custom_appbar.dart';
import 'package:multifunction_camera/widget/custom_scaffold.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
  const GenerateQR({Key? key}) : super(key: key);

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: Text("Generate QR")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // QR Code
            QrImage(
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              data: 'please input qr content',
              embeddedImage: AssetImage(
                'assets/logo/logo.png',
              ),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(53, 53),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
