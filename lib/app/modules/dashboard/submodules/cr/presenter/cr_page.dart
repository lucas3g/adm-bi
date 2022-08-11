import 'package:flutter/material.dart';

class CRPage extends StatefulWidget {
  const CRPage({Key? key}) : super(key: key);

  @override
  State<CRPage> createState() => _CRPageState();
}

class _CRPageState extends State<CRPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Contas a Receber'),
    );
  }
}
