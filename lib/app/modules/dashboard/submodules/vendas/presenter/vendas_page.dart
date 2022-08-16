import 'dart:async';

import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/grafico_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/projecao_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/grafico_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/projecao_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/grafico_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/projecao_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/body_vendas_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/bottom_vendas_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/header_vendas_widget.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class VendasPage extends StatefulWidget {
  final ProjecaoBloc projecaoBloc;
  final GraficoBloc graficoBloc;
  final VendasBloc vendasBloc;

  const VendasPage({
    Key? key,
    required this.projecaoBloc,
    required this.graficoBloc,
    required this.vendasBloc,
  }) : super(key: key);

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  late StreamSubscription subProjecao;
  late StreamSubscription subGrafico;
  late StreamSubscription subVendas;

  @override
  void initState() {
    super.initState();

    widget.projecaoBloc.add(GetProjecaoEvent());
    widget.graficoBloc.add(GetGraficoEvent());
    widget.vendasBloc.add(GetVendasEvent());

    subProjecao = widget.projecaoBloc.stream.listen((state) {
      if (state is ProjecaoErrorState) {
        MySnackBar(message: state.message);
      }
    });

    subGrafico = widget.graficoBloc.stream.listen((state) {
      if (state is GraficoErrorState) {
        MySnackBar(message: state.message);
      }
    });

    subVendas = widget.vendasBloc.stream.listen((state) {
      if (state is VendasErrorState) {
        MySnackBar(message: state.message);
      }
    });
  }

  @override
  void dispose() {
    //SUBS
    subProjecao.cancel();
    subGrafico.cancel();
    subVendas.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: HeaderVendasWidget(
              projecaoBloc: widget.projecaoBloc,
            ),
          ),
          Expanded(
            flex: 5,
            child: BodyVendasWidget(
              graficoBloc: widget.graficoBloc,
            ),
          ),
          Expanded(
            flex: 4,
            child: BottomVendasWidget(
              vendasBloc: widget.vendasBloc,
            ),
          ),
        ],
      ),
    );
  }
}
