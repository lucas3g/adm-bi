import 'dart:async';

import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/events/formas_pag_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/formas_pag_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/states/formas_pag_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/widgets/my_grafico_formas_pag.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/loading_widget.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResumoFormasPage extends StatefulWidget {
  final FormasPagBloc formasPagBloc;
  const ResumoFormasPage({
    Key? key,
    required this.formasPagBloc,
  }) : super(key: key);

  @override
  State<ResumoFormasPage> createState() => _ResumoFormasPageState();
}

class _ResumoFormasPageState extends State<ResumoFormasPage> {
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    //widget.formasPagBloc.add(GetFormasPagEvent());

    sub = widget.formasPagBloc.stream.listen((state) {
      if (state is FormasPagErrorState) {
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
    return BlocListener<CCustoBloc, CCustoStates>(
      bloc: Modular.get<CCustoBloc>(),
      listener: (context, state) {
        widget.formasPagBloc.add(
          FilterFormasPag(
            ccusto: state.selectedEmpresa,
          ),
        );
      },
      child: BlocBuilder<FormasPagBloc, FormasPagStates>(
        bloc: widget.formasPagBloc,
        buildWhen: (previous, current) {
          return current is FormasPagSuccessState;
        },
        builder: (context, state) {
          if (state is! FormasPagSuccessState) {
            return ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, snapshot) {
                return const LoadingWidget(
                  size: Size(0, 55),
                  radius: 10,
                );
              },
            );
          }

          final formasPag = state.filtredList;

          return ListView.builder(
            itemBuilder: (context, index) {
              late bool visible = false;

              if (index == 0 ||
                  formasPag[index].tipo != formasPag[index - 1].tipo) {
                visible = true;
              }

              return Column(
                children: [
                  Visibility(
                    visible: visible,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(),
                        ),
                      ),
                      child: Text(
                        formasPag[index].tipo == 'CR'
                            ? 'Contas a Receber'
                            : 'Contas a Pagar',
                        style: AppTheme.textStyles.titleResumoFp,
                      ),
                    ),
                  ),
                  MyGraficoFormasPagWidget(
                    formasPag: formasPag[index],
                  ),
                ],
              );
            },
            itemCount: formasPag.length,
          );
        },
      ),
    );
  }
}
