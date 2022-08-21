import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Ganerate extends StatefulWidget {
  @override
  _GanerateState createState() => _GanerateState();
}

class _GanerateState extends State<Ganerate> {
  late TextEditingController _input1Controller;
  late TextEditingController _input2Controller;

  @override
  initState() {
    super.initState();
    this._input1Controller = new TextEditingController();
    this._input2Controller = new TextEditingController();
  }

  saveIamge() async {
    final result = await ImageGallerySaver.saveImage(bytes,
        quality: 100, name: _input2Controller.text);
    print(result);
  }

  var outputScandata;
  Uint8List bytes = Uint8List(0);
  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
    saveIamge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganerting QrCode"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09),
          width: MediaQuery.of(context).size.width / 1.1,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(hintText: "QrCode Content"),
                textAlign: TextAlign.center,
                controller: _input1Controller,
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(hintText: "Image title"),
                textAlign: TextAlign.center,
                controller: _input2Controller,
              ),
              SizedBox(height: 30),
              RaisedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _generateBarCode("${_input1Controller.text}");
                  setState(() {
                    outputScandata = "${_input1Controller.text}";
                  });
                },
                child: Text("Gnerate"),
              ),
              SizedBox(height: 40),
              Container(
                child: Center(
                  child: _qrCodeWidget(bytes),
                  // QrImage(data: outputScandata.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes) {
    return SizedBox(
      height: 190,
      child: bytes.isEmpty
          ? Center(
              child: Text('No Qr-code create it Yet',
                  style: TextStyle(color: Colors.black38)),
            )
          : Image.memory(bytes),
    );
  }
}
