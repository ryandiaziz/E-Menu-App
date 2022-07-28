import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../presentation/pages/home/menu_page.dart';
import '../presentation/pages/home/navigation.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  List dataMeja = [];

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
  }

  String? idMeja;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              buildQrView(context),
              Positioned(bottom: 40, child: buildResult()),
            ],
          ),
        ),
      );

  Widget buildResult() {
    return Column(
      children: [
        barcode != null
            ? ElevatedButton(
                onPressed: () {
                  setState(() {
                    idMeja = barcode!.code;
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NavigationPage(
                        idMeja: idMeja!,
                      ),
                    ),
                  );
                },
                child: Text('Lanjut'))
            : const Text(
                'Scan a Code! bro',
                style: TextStyle(color: Colors.white),
                maxLines: 3,
              ),
      ],
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: priceColor,
          borderWidth: 10,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}
