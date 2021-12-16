import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Ganerate extends StatefulWidget {
  @override
  _GanerateState createState() => _GanerateState();
}

class _GanerateState extends State<Ganerate> {
  TextEditingController _input1Controller;
  TextEditingController _input2Controller;
  @override
  initState() {
    super.initState();
    this._input1Controller = new TextEditingController();
    this._input2Controller = new TextEditingController();
  }

  var outputScandata;
  Uint8List bytes = Uint8List(0);
  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
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
              TextField(
                decoration: InputDecoration(hintText: "QrCode Element 1"),
                textAlign: TextAlign.center,
                controller: _input1Controller,
              ),
              TextField(
                decoration: InputDecoration(hintText: "QrCode Element 2"),
                textAlign: TextAlign.center,
                controller: _input2Controller,
              ),
              RaisedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _generateBarCode(
                      "${_input1Controller.text} ${_input2Controller.text}");
                  setState(() {
                    outputScandata =
                        "${_input1Controller.text} ${_input2Controller.text}";
                  });
                },
                child: Text("Gnerate"),
              ),
              Container(
                // width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 1.5,
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
              child: Text('Empty code ... ',
                  style: TextStyle(color: Colors.black38)),
            )
          : Image.memory(bytes),
    );
  }
}
