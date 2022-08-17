import 'dart:async';
import 'dart:io';

import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/contas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/events/contas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/states/contas_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/widgets/my_cards_saldo_cr_cp_widget.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:app_demonstrativo/app/utils/loading_widget.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
  late StreamSubscription sub;

  Color retornarCorCard(String tipo) {
    if (tipo == 'CR') {
      return Colors.green;
    }

    if (tipo == 'CP') {
      return Colors.red;
    }

    if (tipo == 'CX') {
      return Colors.amber;
    }

    if (tipo == 'BC') {
      return Colors.teal;
    }

    if (tipo == 'BO') {
      return Colors.blue;
    }

    return Colors.green.shade700;
  }

  String retornaSubtitleCard(String tipo) {
    if (tipo == 'CR') {
      return 'A receber hoje';
    }

    if (tipo == 'CP') {
      return 'A pagar hoje';
    }

    if (tipo == 'CX') {
      return 'Caixa';
    }

    if (tipo == 'BC') {
      return 'Bancos';
    }

    if (tipo == 'BO') {
      return 'Boletos';
    }

    return 'Saldo Geral';
  }

  @override
  void initState() {
    super.initState();

    widget.contasBloc.add(GetContasEvent());

    sub = widget.contasBloc.stream.listen((state) {
      if (state is ContasErrorState) {
        MySnackBar(message: state.message);
      }
    });
  }

  @override
  void dispose() {
    //SUBS
    sub.cancel();

    super.dispose();
  }

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
                child: BlocListener<CCustoBloc, CCustoStates>(
                  bloc: Modular.get<CCustoBloc>(),
                  listener: (context, state) {
                    widget.contasBloc.add(
                      ContasFilterEvent(
                        ccusto: state.selectedEmpresa,
                      ),
                    );
                  },
                  child: BlocBuilder<ContasBloc, ContasStates>(
                      bloc: widget.contasBloc,
                      buildWhen: (previous, current) {
                        return current is ContasSuccessState;
                      },
                      builder: (context, state) {
                        if (state is! ContasSuccessState) {
                          return const LoadingWidget(
                            size: Size(0, 200),
                            radius: 10,
                          );
                        }

                        final contas = state.filtredList;

                        if (contas.isEmpty) {
                          return const Text('Nenhum dado encontrado para hoje');
                        }

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: contas.length,
                          itemBuilder: (context, index) {
                            return MyCardsSaldoCRCP(
                              backGroundColor:
                                  retornarCorCard(contas[index].tipo),
                              saldo: contas[index].total,
                              subtitle: retornaSubtitleCard(contas[index].tipo),
                            );
                          },
                        );
                      }),
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
