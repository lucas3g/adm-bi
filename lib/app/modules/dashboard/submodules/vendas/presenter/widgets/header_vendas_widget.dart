import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:speed_bi/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/projecao_events.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/projecao_bloc.dart';
import 'package:speed_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/states/projecao_states.dart';
import 'package:speed_bi/app/theme/app_theme.dart';
import 'package:speed_bi/app/utils/constants.dart';
import 'package:speed_bi/app/utils/formatters.dart';
import 'package:speed_bi/app/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HeaderVendasWidget extends StatefulWidget {
  final ProjecaoBloc projecaoBloc;
  const HeaderVendasWidget({
    Key? key,
    required this.projecaoBloc,
  }) : super(key: key);

  @override
  State<HeaderVendasWidget> createState() => _HeaderVendasWidgetState();
}

class _HeaderVendasWidgetState extends State<HeaderVendasWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocListener<CCustoBloc, CCustoStates>(
            bloc: Modular.get<CCustoBloc>(),
            listener: (context, state) {
              widget.projecaoBloc.add(
                ProjecaoFilterEvent(ccusto: state.selectedEmpresa),
              );
            },
            child: BlocBuilder<ProjecaoBloc, ProjecaoStates>(
                bloc: widget.projecaoBloc,
                buildWhen: (previous, current) {
                  return current is ProjecaoSuccessState;
                },
                builder: (context, state) {
                  if (state is! ProjecaoSuccessState) {
                    return Column(
                      children: [
                        LoadingWidget(
                          size: Size(context.screenWidth * .88, 40),
                          radius: 10,
                        ),
                      ],
                    );
                  }

                  final projecao = state.filtredList;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Hoje',
                            style: AppTheme.textStyles.titleHeaderDashBoard,
                          ),
                          projecao.isNotEmpty
                              ? Text(
                                  projecao[0].totalDiario.reais(),
                                  style: AppTheme
                                      .textStyles.subTitleHeaderDashBoard,
                                )
                              : Text(
                                  '0.00',
                                  style: AppTheme
                                      .textStyles.subTitleHeaderDashBoard,
                                ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Mês',
                            style: AppTheme.textStyles.titleHeaderDashBoard,
                          ),
                          projecao.isNotEmpty
                              ? Text(
                                  projecao[0].totalMes.reais(),
                                  style: AppTheme
                                      .textStyles.subTitleHeaderDashBoard,
                                )
                              : Text(
                                  '0.00',
                                  style: AppTheme
                                      .textStyles.subTitleHeaderDashBoard,
                                ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Lucro',
                            style: AppTheme.textStyles.titleHeaderDashBoard,
                          ),
                          projecao.isNotEmpty
                              ? Text(
                                  projecao[0].lucro.reais(),
                                  style: AppTheme
                                      .textStyles.subTitleHeaderDashBoard,
                                )
                              : Text(
                                  '0.00',
                                  style: AppTheme
                                      .textStyles.subTitleHeaderDashBoard,
                                ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
