import 'package:flutter/material.dart';
import 'package:multifunction_camera/page/widget/generate_qr.dart';
import 'package:multifunction_camera/widget/custom_appbar.dart';
import 'package:multifunction_camera/widget/custom_button.dart';
import 'package:multifunction_camera/page/qr_scan_page.dart';
import 'package:multifunction_camera/widget/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: const Text('KTools'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Generate QR
              CustomButton(
                clickCallback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const GenerateQR(),
                  ));
                },
                text: const Text('Generate QR',
                    style: TextStyle(color: Colors.white)),
              ),
              // Scan QR
              CustomButton(
                clickCallback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRScanPage(),
                  ));
                },
                text: const Text('Scan QR',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
