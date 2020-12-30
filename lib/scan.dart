import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scan;
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String data = "No QrCode data yet!!";
  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  void initState() {
    super.initState();
    getScan();
  }

  Future<Null> refrehs() async {
    setState(() {
      data = "";
    });
    getScan();
    await Future.delayed(Duration(seconds: 2));
  }

  bool urlVaild(String str) {
    var urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    var match = new RegExp(urlPattern, caseSensitive: false).firstMatch(str);
    if (match == null) {
      return false;
    } else
      return true;
  }

  Future getScan() async {
    await Permission.camera.request();
    await Permission.storage.request();
    String dataScan = await scan.scan();
    setState(() {
      data = dataScan.toString();
    });
  }

  Widget content(String dataStr) {
    if (urlVaild(data)) {
      return Linkify(
        onOpen: _onOpen,
        text: data,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      );
    } else {
      return Text(
        data,
        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QrCode"),
      ),
      body: RefreshIndicator(
        onRefresh: refrehs,
        child: SingleChildScrollView(
          // physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Center(
              child: content(data),
            ),
            height: MediaQuery.of(context).size.height / 1.14,
          ),
        ),
      ),
    );
  }
}
