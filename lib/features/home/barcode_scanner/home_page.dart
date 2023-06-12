import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nascon_security_app/core/app%20cubit/app_state.dart';
import 'package:nascon_security_app/features/home/barcode_scanner/bloc/home_bloc.dart';
import 'package:nascon_security_app/features/home/barcode_scanner/bloc/home_event.dart';

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
        title: Text(context.read<HomeBloc>().appCubit.state is SecurityAuthorizedAppState?
        'Nascon Security': 'Nascon Food'),
        actions: [
          IconButton(onPressed: (){
            context.read<HomeBloc>().add(Logout());
            context.goNamed('role');
          }, icon: const Icon(Icons.logout),)
        ],
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

              if(context.read<HomeBloc>().appCubit.state is SecurityAuthorizedAppState) {
                context.goNamed(
                    'user_details', queryParams: {'id': barcodeScanRes});
              }
              else{
                context.goNamed(
                    'food_details', queryParams: {'id': barcodeScanRes});
              }
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
