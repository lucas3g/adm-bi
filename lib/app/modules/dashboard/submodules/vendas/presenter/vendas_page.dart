import 'dart:async';

import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/body_vendas_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/bottom_vendas_widget.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/widgets/header_vendas_widget.dart';
import 'package:app_demonstrativo/app/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class VendasPage extends StatefulWidget {
  final VendasBloc vendasBloc;
  const VendasPage({Key? key, required this.vendasBloc}) : super(key: key);

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.vendasBloc.add(GetVendasEvent());

    sub = widget.vendasBloc.stream.listen((state) {
      if (state is VendasErrorState) {
        MySnackBar(message: 'Erro ao buscar vendas');
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    widget.vendasBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: HeaderVendasWidget(),
          ),
          const Expanded(
            flex: 5,
            child: BodyVendasWidget(),
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
