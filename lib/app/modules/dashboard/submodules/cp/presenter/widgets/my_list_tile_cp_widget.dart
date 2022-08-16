import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/domain/entities/cp_entity.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';

class MyListTileCPWidget extends StatefulWidget {
  final CP cp;
  const MyListTileCPWidget({
    Key? key,
    required this.cp,
  }) : super(key: key);

  @override
  State<MyListTileCPWidget> createState() => _MyListTileCPWidgetState();
}

class _MyListTileCPWidgetState extends State<MyListTileCPWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(widget.cp.nome),
          ),
          Text(
            widget.cp.valor.reais(),
            style: AppTheme.textStyles.saldoClienteCRCP,
          ),
        ],
      ),
    );
  }
}
