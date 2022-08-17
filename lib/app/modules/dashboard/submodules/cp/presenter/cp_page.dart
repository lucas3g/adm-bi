import 'dart:async';

import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/components/my_input_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/cp_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/events/cp_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/states/cp_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/widgets/my_list_tile_cp_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:app_demonstrativo/app/utils/loading_widget.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CPPage extends StatefulWidget {
  final CPBloc cpBloc;
  const CPPage({
    Key? key,
    required this.cpBloc,
  }) : super(key: key);

  @override
  State<CPPage> createState() => _CPPageState();
}

class _CPPageState extends State<CPPage> {
  final fPesquisa = FocusNode();
  final pesquisaController = TextEditingController();
  final gkPesquisa = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    widget.cpBloc.add(GetCPEvent());

    sub = widget.cpBloc.stream.listen((state) {
      if (state is CPErrorState) {
        MySnackBar(message: state.message);
      }

      if (state is CPSuccessState) {
        widget.cpBloc.add(
          CPFilterEvent(
            ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
            filtro: '',
          ),
        );
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
      body: Column(
        children: [
          MyInputWidget(
            focusNode: fPesquisa,
            hintText: 'Digite o nome do cliente',
            label: 'Pesquisa',
            textEditingController: pesquisaController,
            formKey: gkPesquisa,
            inputFormaters: [
              UpperCaseTextFormatter(),
            ],
            onChanged: (String? value) {
              widget.cpBloc.add(
                CPFilterEvent(
                  ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
                  filtro: value!,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocListener<CCustoBloc, CCustoStates>(
            bloc: Modular.get<CCustoBloc>(),
            listener: (context, state) {
              widget.cpBloc.add(
                CPFilterEvent(ccusto: state.selectedEmpresa, filtro: ''),
              );
            },
            child: BlocBuilder<CPBloc, CPStates>(
              bloc: widget.cpBloc,
              buildWhen: (previous, current) {
                return current is CPFilteredState;
              },
              builder: (context, state) {
                if (state is! CPFilteredState && state is! CPSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, snapshot) {
                        return const LoadingWidget(
                          size: Size(0, 55),
                          radius: 10,
                        );
                      },
                    ),
                  );
                }

                final cps = state.filtredList;

                if (cps.isEmpty) {
                  return const Center(
                    child: Text('Nenhum cliente encontrado.'),
                  );
                }

                final totalGeral = state.saldoCp;

                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Geral',
                              style: AppTheme.textStyles.titleTotalGeralCRCP,
                            ),
                            Text(
                              totalGeral.reais(),
                              style: AppTheme.textStyles.totalGeralClienteCRCP,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return MyListTileCPWidget(cp: cps[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: cps.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
