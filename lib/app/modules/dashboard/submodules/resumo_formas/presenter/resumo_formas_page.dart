import 'package:flutter/material.dart';

class ResumoFormasPage extends StatefulWidget {
  const ResumoFormasPage({Key? key}) : super(key: key);

  @override
  State<ResumoFormasPage> createState() => _ResumoFormasPageState();
}

class _ResumoFormasPageState extends State<ResumoFormasPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Resumo das Formas de Pagamento'),
    );
  }
}
