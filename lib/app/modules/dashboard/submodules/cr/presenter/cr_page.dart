import 'dart:async';

import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/components/my_input_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/states/cr_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/widgets/my_list_tile_cr_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:app_demonstrativo/app/utils/loading_widget.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CRPage extends StatefulWidget {
  final CRBloc crBloc;
  const CRPage({
    Key? key,
    required this.crBloc,
  }) : super(key: key);

  @override
  State<CRPage> createState() => _CRPageState();
}

class _CRPageState extends State<CRPage> {
  final fPesquisa = FocusNode();
  final pesquisaController = TextEditingController();
  final gkPesquisa = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.crBloc.add(GetCREvent());

    sub = widget.crBloc.stream.listen((state) {
      if (state is CRErrorState) {
        MySnackBar(message: state.message);
      }

      if (state is CRSuccessState) {
        widget.crBloc.add(
          CRFilterEvent(
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
              widget.crBloc.add(
                CRFilterEvent(
                  ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
                  filtro: value!,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocListener<CCustoBloc, CCustoStates>(
            bloc: Modular.get<CCustoBloc>(),
            listenWhen: (previous, current) {
              return current is CCustoSuccessState;
            },
            listener: (context, state) {
              widget.crBloc.add(
                CRFilterEvent(ccusto: state.selectedEmpresa, filtro: ''),
              );
            },
            child: BlocBuilder<CRBloc, CRStates>(
              bloc: widget.crBloc,
              buildWhen: (previous, current) {
                return current is CRFilteredState;
              },
              builder: (context, state) {
                if (state is! CRFilteredState && state is! CRSuccessState) {
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

                final crs = state.filtredList;

                if (crs.isEmpty) {
                  return const Center(
                    child: Text('Nenhum cliente encontrado.'),
                  );
                }

                final totalGeral = crs
                    .map((cr) => cr.valor)
                    .reduce((value, element) => value + element)
                    .toDouble();

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
                              return MyListTileCRWidget(cr: crs[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: crs.length,
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
