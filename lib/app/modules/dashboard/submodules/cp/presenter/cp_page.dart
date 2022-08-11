import 'package:flutter/material.dart';

class CPPage extends StatefulWidget {
  const CPPage({Key? key}) : super(key: key);

  @override
  State<CPPage> createState() => _CPPageState();
}

class _CPPageState extends State<CPPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Contas a Pagar'),
    );
  }
}
