// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:speed_bi/app/components/my_input_widget.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/presenter/blocs/events/estoque_events.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/estoque/presenter/blocs/states/estoque_states.dart';
import 'package:speed_bi/app/theme/app_theme.dart';
import 'package:speed_bi/app/utils/formatters.dart';
import 'package:speed_bi/app/utils/loading_widget.dart';
import 'package:speed_bi/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

import 'package:speed_bi/app/modules/dashboard/submodules/estoque/presenter/blocs/estoque_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EstoquePage extends StatefulWidget {
  final EstoqueBloc estoqueBloc;

  const EstoquePage({
    Key? key,
    required this.estoqueBloc,
  }) : super(key: key);

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final fPesquisa = FocusNode();
  final pesquisaController = TextEditingController();
  final gkPesquisa = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    sub = widget.estoqueBloc.stream.listen((state) {
      if (state is EstoqueErrorState) {
        MySnackBar(message: state.message);
      }

      if (state is EstoqueSuccessState) {
        widget.estoqueBloc.add(
          EstoqueFilterEvent(
            ccusto: Modular.get<CCustoBloc>().state.selectedEmpresa,
            filtro: '',
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    //SUB
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
              widget.estoqueBloc.add(
                EstoqueFilterEvent(
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
              FocusScope.of(context).requestFocus(FocusNode());
              pesquisaController.clear();
              widget.estoqueBloc.add(
                EstoqueFilterEvent(ccusto: state.selectedEmpresa, filtro: ''),
              );
            },
            child: BlocBuilder<EstoqueBloc, EstoqueStates>(
              bloc: widget.estoqueBloc,
              buildWhen: (previous, current) {
                return current is EstoqueFilteredState;
              },
              builder: (context, state) {
                if (state is! EstoqueFilteredState &&
                    state is! EstoqueSuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return const LoadingWidget(
                            size: Size(0, 40), radius: 10);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: 10,
                    ),
                  );
                }

                final estoques = state.filtredList;

                if (estoques.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('Nenhuma mercadoria encontrada.'),
                    ),
                  );
                }

                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(),
                          ),
                        ),
                        child: Text(
                          'Mercadorias com Estoque Minimo',
                          style: AppTheme.textStyles.titleEstoque,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(estoques[index].descricao),
                              trailing: Text(
                                estoques[index].estoque.Litros(),
                                style: AppTheme.textStyles.saldoClienteCRCP,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: estoques.length,
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
