// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_demonstrativo/app/components/drop_down_widget.dart';
import 'package:app_demonstrativo/app/components/my_elevated_button_widget.dart';
import 'package:app_demonstrativo/app/components/my_title_app_bar_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Modular.to.navigate('./vendas/');
  }

  void confirmarSair() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(bottom: 15, top: 20, right: 20, left: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/sair.svg',
                height: 130,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Deseja realmente sair da aplicação?',
                style: AppTheme.textStyles.textoSairApp.copyWith(fontSize: 16),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyElevatedButtonWidget(
                      label: Text(
                        'Não',
                        style: AppTheme.textStyles.titleAppBar
                            .copyWith(fontSize: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backGroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: MyElevatedButtonWidget(
                      label: const Text('Sim'),
                      onPressed: () async {
                        await Future.delayed(const Duration(milliseconds: 150));
                        Navigator.pop(context);
                        Modular.to.navigate('/auth/');
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          height + (Platform.isWindows ? 70 : 60),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: height + (Platform.isWindows ? 20 : 40),
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: AppTheme.colors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyTitleAppBarWidget(index: _currentIndex),
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      confirmarSair();
                    },
                  )
                ],
              ),
            ),
            Container(),
            Positioned(
              top: (Platform.isWindows ? 55 : 70),
              left: 20.0,
              right: 20.0,
              child: const DropDownWidget(),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: const RouterOutlet(),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: AppTheme.colors.primary,
        backgroundColor: Colors.white,
        height: 60,
        items: [
          Icon(
            _currentIndex == 0
                ? Icons.payments_rounded
                : Icons.payments_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            _currentIndex == 1
                ? Icons.analytics_rounded
                : Icons.analytics_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            _currentIndex == 2
                ? Icons.receipt_long
                : Icons.receipt_long_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            _currentIndex == 3
                ? Icons.call_received
                : Icons.call_received_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            _currentIndex == 4 ? Icons.call_made : Icons.call_made_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            _currentIndex == 5
                ? Icons.inventory_2_rounded
                : Icons.inventory_2_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Modular.to.navigate('/dash/vendas/');
          }
          if (index == 1) {
            Modular.to.navigate('/dash/contas/');
          }
          if (index == 2) {
            Modular.to.navigate('/dash/resumo_fp/');
          }
          if (index == 3) {
            Modular.to.navigate('/dash/cr/');
          }
          if (index == 4) {
            Modular.to.navigate('/dash/cp/');
          }
          if (index == 5) {
            Modular.to.navigate('/dash/estoque/');
          }
        },
      ),
    );
  }
}
