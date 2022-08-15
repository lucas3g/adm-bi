import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:app_demonstrativo/app/utils/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomVendasWidget extends StatefulWidget {
  final VendasBloc vendasBloc;
  const BottomVendasWidget({
    Key? key,
    required this.vendasBloc,
  }) : super(key: key);

  @override
  State<BottomVendasWidget> createState() => _BottomVendasWidgetState();
}

class _BottomVendasWidgetState extends State<BottomVendasWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Últimas 10 vendas de hoje',
          style: AppTheme.textStyles.titleResumoVendas,
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BlocListener<CCustoBloc, CCustoStates>(
              bloc: Modular.get<CCustoBloc>(),
              listener: (context, state) {
                widget.vendasBloc.add(
                  VendasFilterEvent(ccusto: state.selectedEmpresa),
                );
              },
              child: BlocBuilder<VendasBloc, VendasStates>(
                  bloc: widget.vendasBloc,
                  builder: (context, state) {
                    if (state is! VendasSuccessState) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return const LoadingWidget(
                            size: Size(double.maxFinite, 40),
                            radius: 10,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: 5,
                      );
                    }

                    final vendas = state.filtredList;

                    if (vendas.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma venda efetuada hoje.'),
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(vendas[index].nome),
                          subtitle: Text('Pedido: ${vendas[index].codPedido}'),
                          trailing: Text(
                            vendas[index].valor.reais(),
                            style: AppTheme.textStyles.valorResumoVendas,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                      ),
                      itemCount: vendas.length,
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
