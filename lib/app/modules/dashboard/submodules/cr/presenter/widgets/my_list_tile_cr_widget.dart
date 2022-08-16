import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/domain/entities/cr_entity.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';

class MyListTileCRWidget extends StatefulWidget {
  final CR cr;
  const MyListTileCRWidget({
    Key? key,
    required this.cr,
  }) : super(key: key);

  @override
  State<MyListTileCRWidget> createState() => _MyListTileCRWidgetState();
}

class _MyListTileCRWidgetState extends State<MyListTileCRWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(widget.cr.nome),
          ),
          Text(
            widget.cr.valor.reais(),
            style: AppTheme.textStyles.saldoClienteCRCP,
          ),
        ],
      ),
    );
  }
}
