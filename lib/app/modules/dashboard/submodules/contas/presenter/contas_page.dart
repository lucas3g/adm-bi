import 'dart:io';

import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/contas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/widgets/my_cards_saldo_cr_cp_widget.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ContasPage extends StatefulWidget {
  final ContasBloc contasBloc;
  const ContasPage({
    Key? key,
    required this.contasBloc,
  }) : super(key: key);

  @override
  State<ContasPage> createState() => _ContasPageState();
}

class _ContasPageState extends State<ContasPage> {
  final double saldo = 500;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          bottom: context.screenHeight * (Platform.isWindows ? .05 : .18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.7,
                  children: const [
                    MyCardsSaldoCRCP(
                      backGroundColor: Colors.green,
                      saldo: 15000.35,
                      subtitle: 'A receber hoje',
                    ),
                    MyCardsSaldoCRCP(
                      backGroundColor: Colors.red,
                      saldo: 68550.00,
                      subtitle: 'A pagar hoje',
                    ),
                    MyCardsSaldoCRCP(
                      backGroundColor: Colors.amber,
                      saldo: 850.00,
                      subtitle: 'Caixa',
                    ),
                    MyCardsSaldoCRCP(
                      backGroundColor: Colors.blue,
                      saldo: 9100.00,
                      subtitle: 'Boletos',
                    ),
                    MyCardsSaldoCRCP(
                      backGroundColor: Colors.teal,
                      saldo: 685.00,
                      subtitle: 'Bancos',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyCardsSaldoCRCP(
                    backGroundColor:
                        saldo < 0 ? Colors.red : Colors.green.shade700,
                    saldo: saldo,
                    subtitle: 'Saldo Geral',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
