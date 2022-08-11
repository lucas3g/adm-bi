import 'dart:io';

import 'package:app_demonstrativo/app/components/drop_down_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final int currentIndex;
  final Size size;
  final BuildContext context;

  const AppBarWidget(
      {Key? key,
      required this.currentIndex,
      required this.size,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Widget get child => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.colors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: Platform.isIOS ? 30 : 20,
                  left: 20,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      currentIndex == 0
                          ? 'Vendas'
                          : currentIndex == 1
                              ? 'Tanques de Combustível'
                              : 'Saldo - Contas a Receber',
                      style: AppTheme.textStyles.titleAppBar,
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                      ),
                      onPressed: () async {},
                    )
                  ],
                ),
              ),
              const DropDownWidget(),
            ],
          ),
        ],
      );

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 40);
}
