import 'package:flutter/material.dart';
import './scan.dart';
import './ganerate.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Widget flatButton(String str, Widget wid) {
    return FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => wid));
      },
      child: Text(
        str,
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Raleway',
        ),
      ),
      padding: EdgeInsets.fromLTRB(50, 6, 50, 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red, width: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("QR Core Scan and Ganerate"), centerTitle: true),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            flatButton("   Scan QrCode   ", Scan()),
            SizedBox(height: 10),
            flatButton("Ganerate QrCode", Ganerate()),
          ],
        ),
      ),
    );
  }
}
