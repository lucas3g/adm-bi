import 'dart:async';

import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/contas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/events/contas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/states/contas_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/widgets/my_cards_saldo_cr_cp_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/widgets/my_loading_contas_widget.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
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
  late String diaSemanaMes = 'Dia';

  retornaDiaSemanaMes(int ccusto, bool back, bool forward) {
    if (back) {
      if (diaSemanaMes == 'Mes') {
        setState(() {
          diaSemanaMes = 'Semana';
        });
        widget.contasBloc.add(
          ContasFilterEvent(
            ccusto: ccusto,
            diaSemanaMes: diaSemanaMes,
          ),
        );
        return;
      }

      if (diaSemanaMes == 'Semana') {
        setState(() {
          diaSemanaMes = 'Dia';
        });
        widget.contasBloc.add(
          ContasFilterEvent(
            ccusto: ccusto,
            diaSemanaMes: diaSemanaMes,
          ),
        );
        return;
      }
    }

    if (forward) {
      if (diaSemanaMes == 'Dia') {
        setState(() {
          diaSemanaMes = 'Semana';
        });
        widget.contasBloc.add(
          ContasFilterEvent(
            ccusto: ccusto,
            diaSemanaMes: diaSemanaMes,
          ),
        );
        return;
      }

      if (diaSemanaMes == 'Semana') {
        setState(() {
          diaSemanaMes = 'Mes';
        });
        widget.contasBloc.add(
          ContasFilterEvent(
            ccusto: ccusto,
            diaSemanaMes: diaSemanaMes,
          ),
        );
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    //widget.contasBloc.add(GetContasEvent());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: BlocListener<CCustoBloc, CCustoStates>(
          bloc: Modular.get<CCustoBloc>(),
          listener: (context, stateCCusto) {
            widget.contasBloc.add(
              ContasFilterEvent(
                ccusto: stateCCusto.selectedEmpresa,
                diaSemanaMes: diaSemanaMes,
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
                return const MyLoadingContasWidget();
              }

              final contas = state.filtredList;

              if (contas.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhuma conta a receber ou pagar para hoje.',
                  ),
                );
              }

              final double saldo = state.saldoGeral;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (diaSemanaMes != 'Dia') ...[
                          IconButton(
                            splashRadius: 10,
                            onPressed: () {
                              retornaDiaSemanaMes(state.ccusto, true, false);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                        ] else
                          const SizedBox(
                            width: 30,
                          ),
                        Text(diaSemanaMes),
                        if (diaSemanaMes != 'Mes') ...[
                          IconButton(
                            splashRadius: 10,
                            onPressed: () {
                              retornaDiaSemanaMes(state.ccusto, false, true);
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                        ] else
                          const SizedBox(
                            width: 30,
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      alignment: Alignment.center,
                      width: context.screenWidth,
                      padding: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(),
                        ),
                      ),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.7,
                        ),
                        itemCount: contas.length,
                        itemBuilder: (context, index) {
                          return MyCardsSaldoCRCP(
                            backGroundColor: Color(contas[index].cardColor),
                            saldo: diaSemanaMes == 'Dia'
                                ? contas[index].totalDiario
                                : diaSemanaMes == 'Semana'
                                    ? contas[index].totalSemanal
                                    : contas[index].totalMes,
                            subtitle: contas[index]
                                .cardSubtitle
                                .replaceAll('1', '')
                                .replaceAll('2', ''),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: MyCardsSaldoCRCP(
                            backGroundColor: saldo < 0
                                ? const Color(0xfffe2836)
                                : const Color(0xff4bac35),
                            saldo: saldo,
                            subtitle: 'Saldo Geral',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
