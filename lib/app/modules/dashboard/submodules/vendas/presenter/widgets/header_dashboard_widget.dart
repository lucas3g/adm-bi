import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HeaderDashBoardWidget extends StatefulWidget {
  const HeaderDashBoardWidget({Key? key}) : super(key: key);

  @override
  State<HeaderDashBoardWidget> createState() => _HeaderDashBoardWidgetState();
}

class _HeaderDashBoardWidgetState extends State<HeaderDashBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Hoje',
                    style: AppTheme.textStyles.titleHeaderDashBoard,
                  ),
                  Text(
                    'R\$ 5.000,35',
                    style: AppTheme.textStyles.subTitleHeaderDashBoard,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    'Semana',
                    style: AppTheme.textStyles.titleHeaderDashBoard,
                  ),
                  Text(
                    'R\$ 65.000,35',
                    style: AppTheme.textStyles.subTitleHeaderDashBoard,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    'Projeção',
                    style: AppTheme.textStyles.titleHeaderDashBoard,
                  ),
                  Text(
                    'R\$ 1.005.000,35',
                    style: AppTheme.textStyles.subTitleHeaderDashBoard,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
