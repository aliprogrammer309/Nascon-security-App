import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key? key}) : super(key: key);

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Type'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              context.pushNamed('login', queryParams: {"role":"security"},);
            }, child: const Text('Security'),),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              context.pushNamed('login', queryParams: {"role":"food"},);
            }, child: const Text('Food'),)
          ],
        ),
      ),
    );
  }
}
