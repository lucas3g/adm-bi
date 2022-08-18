import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';

class MyCardsSaldoCRCP extends StatefulWidget {
  final Color backGroundColor;
  final double saldo;
  final String subtitle;
  const MyCardsSaldoCRCP({
    Key? key,
    required this.backGroundColor,
    required this.saldo,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<MyCardsSaldoCRCP> createState() => _MyCardsSaldoCRCPState();
}

class _MyCardsSaldoCRCPState extends State<MyCardsSaldoCRCP> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backGroundColor,
      elevation: 5,
      shadowColor: widget.backGroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                widget.saldo < 0
                    ? 'R\$ ${widget.saldo.reaisSemR()}'
                    : widget.saldo.reais(),
                style: AppTheme.textStyles.valorCRCP,
              ),
            ),
            FittedBox(
              child: Text(
                widget.subtitle,
                style: AppTheme.textStyles.subTitleCRCP,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
