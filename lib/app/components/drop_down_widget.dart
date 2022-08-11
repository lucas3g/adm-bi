import 'package:app_demonstrativo/app/theme/app_theme.dart';

import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
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
              color: AppTheme.colors.primary.withOpacity(0.23)),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(20),
            value: 'EL Sistemas Matriz',
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_circle_down_sharp,
            ),
            iconSize: 30,
            elevation: 8,
            iconEnabledColor: AppTheme.colors.primary,
            style: AppTheme.textStyles.textoSairApp,
            underline: Container(),
            onChanged: (newValue) {},
            items: ['EL Sistemas Matriz', 'EL Sistemas Filial'].map((local) {
              return DropdownMenuItem(
                value: local,
                child: Text(local),
              );
            }).toList(),
          )),
    );
  }
}
