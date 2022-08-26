import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/events/ccusto_event.dart';
import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/states/ccusto_state.dart';
import 'package:adm_bi/app/theme/app_theme.dart';
import 'package:adm_bi/app/utils/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownWidget extends StatefulWidget {
  final CCustoBloc ccustoBloc;
  const DropDownWidget({
    Key? key,
    required this.ccustoBloc,
  }) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  void initState() {
    super.initState();

    widget.ccustoBloc.add(GetCCustoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 10,
            color: AppTheme.colors.primary.withOpacity(0.23),
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<CCustoBloc, CCustoStates>(
              bloc: widget.ccustoBloc,
              buildWhen: (previous, current) {
                return current is CCustoSuccessState;
              },
              builder: (context, state) {
                if (state is! CCustoSuccessState) {
                  return Row(
                    children: const [
                      Expanded(
                        child: LoadingWidget(size: Size(0, 40), radius: 10),
                      ),
                    ],
                  );
                }

                final ccustos = state.ccustos;
                final initialValue = state.selectedEmpresa;

                return DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  value: initialValue,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_circle_down_sharp,
                  ),
                  iconSize: 30,
                  elevation: 8,
                  iconEnabledColor: AppTheme.colors.primary,
                  style: AppTheme.textStyles.textoSairApp,
                  underline: Container(),
                  onChanged: (int? newValue) {
                    widget.ccustoBloc.add(ChangeCCustoEvent(ccusto: newValue!));
                  },
                  items: ccustos.map((local) {
                    return DropdownMenuItem(
                      value: local.ccusto,
                      child: Text(local.descricao),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
