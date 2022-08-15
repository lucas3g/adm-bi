import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/domain/entities/grafico_vendas.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/grafico_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/grafico_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/grafico_states.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:app_demonstrativo/app/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BodyVendasWidget extends StatefulWidget {
  final GraficoBloc graficoBloc;

  const BodyVendasWidget({
    Key? key,
    required this.graficoBloc,
  }) : super(key: key);

  @override
  State<BodyVendasWidget> createState() => _BodyVendasWidgetState();
}

class _BodyVendasWidgetState extends State<BodyVendasWidget> {
  late List<VendasSemanais> listaNova = [];

  montaGrafico(List<GraficoVendas> vendasGrafico) {
    listaNova.clear();

    listaNova.addAll(
      vendasGrafico.map(
        (e) => VendasSemanais(e.data, e.total),
      ),
    );

    listaNova.sort((a, b) => a.dia.isAfter(b.dia) ? 1 : -1);

    return listaNova;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * .37,
      child: BlocListener<CCustoBloc, CCustoStates>(
        bloc: Modular.get<CCustoBloc>(),
        listener: (context, state) {
          widget.graficoBloc.add(
            GraficoFilterEvent(ccusto: state.selectedEmpresa),
          );
        },
        child: BlocBuilder<GraficoBloc, GraficoStates>(
            bloc: widget.graficoBloc,
            builder: (context, state) {
              if (state is! GraficoSuccessState) {
                return Column(
                  children: const [
                    Expanded(
                      child: LoadingWidget(
                        size: Size(double.maxFinite, 40),
                        radius: 10,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                );
              }

              final vendas = state.filtredList;

              return SfCartesianChart(
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  color: Colors.white,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  shadowColor: AppTheme.colors.primary,
                ),
                onTooltipRender: (TooltipArgs args) {
                  final DateTime data = listaNova[args.pointIndex as int].dia;
                  final double valor = listaNova[args.pointIndex as int].valor;
                  args.header = 'Dia - ${data.DiaMes()}';
                  args.text = valor.reais();
                },
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.simpleCurrency(locale: 'pt-br'),
                ),
                series: <CartesianSeries<VendasSemanais, String>>[
                  AreaSeries<VendasSemanais, String>(
                    color: AppTheme.colors.primary,
                    dataSource: montaGrafico(vendas),
                    xValueMapper: (VendasSemanais vendas, _) =>
                        vendas.dia.Dia(),
                    yValueMapper: (VendasSemanais vendas, _) => vendas.valor,
                    markerSettings: const MarkerSettings(
                        isVisible: true, shape: DataMarkerType.circle),
                  )
                ],
                title: ChartTitle(
                  text: 'Vendas dos últimos 7 dias',
                  textStyle: AppTheme.textStyles.titleGraficoVendas,
                ),
              );
            }),
      ),
    );
  }
}

class VendasSemanais {
  VendasSemanais(this.dia, this.valor);
  final DateTime dia;
  final double valor;
}
