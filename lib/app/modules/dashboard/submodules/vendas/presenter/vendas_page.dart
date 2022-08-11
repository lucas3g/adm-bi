import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/header_dashboard_widget.dart';
import 'package:flutter/material.dart';

class VendasPage extends StatefulWidget {
  const VendasPage({Key? key}) : super(key: key);

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HeaderDashBoardWidget(),
    );
  }
}
