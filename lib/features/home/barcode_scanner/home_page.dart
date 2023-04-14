import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NasCon Security'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666',
                'Cancel',
                true,
                ScanMode.QR,
              );

              log(barcodeScanRes);

              context.goNamed('user_details', queryParams: {'id': barcodeScanRes});
            }
            catch (e){
              log(e.toString());
            }
          },
          child: const Text('Scan QR Code'),
        ),
      ),
    );
  }
}
