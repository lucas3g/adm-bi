// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:adm_bi/app/theme/app_theme.dart';

class IconsBottomBarWidget extends StatelessWidget {
  final String label;
  final IconData iconRounded;
  final IconData iconOutlined;
  final int indexIcon;
  final int currentIndex;
  const IconsBottomBarWidget({
    Key? key,
    required this.label,
    required this.iconRounded,
    required this.iconOutlined,
    required this.indexIcon,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: currentIndex != indexIcon,
          child: const SizedBox(height: 5),
        ),
        Icon(
          currentIndex == indexIcon ? iconRounded : iconOutlined,
          size: 25,
          color: Colors.white,
        ),
        Visibility(
          visible: currentIndex != indexIcon,
          child: Text(
            label,
            style: AppTheme.textStyles.labelIconsBottomBar,
          ),
        ),
      ],
    );
  }
}
