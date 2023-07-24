import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multifunction_camera/widget/custom_appbar.dart';
import 'package:multifunction_camera/widget/custom_scaffold.dart';

//todo 点击自动保存到剪切板

class BlankPage extends StatefulWidget {
  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  String _tips = '点击复制到剪切板';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String str = ModalRoute.of(context)!.settings.arguments.toString();
    return CustomScaffold(
      appBar: CustomAppBar(
        title: Text('Scan Result'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // click to copy to clipboard
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: str));
              setState(() {
                _tips = '已复制!';
                EasyLoading.showToast("已成功复制到剪切板");
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: Text(
                str,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

          // Tips
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 10,
            child: Text(
              _tips,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
