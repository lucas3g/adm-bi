// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:adm_bi/app/components/drop_down_widget/presenter/drop_down_widget.dart';
import 'package:adm_bi/app/components/my_elevated_button_widget.dart';
import 'package:adm_bi/app/components/my_title_app_bar_widget.dart';
import 'package:adm_bi/app/core_module/constants/constants.dart';
import 'package:adm_bi/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:adm_bi/app/modules/dashboard/presenter/controllers/dashboard_controller.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/states/vendas_states.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:adm_bi/app/theme/app_theme.dart';
import 'package:adm_bi/app/utils/constants.dart';
import 'package:adm_bi/app/utils/formatters.dart';
import 'package:adm_bi/app/utils/loading_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashBoardPage extends StatefulWidget {
  final CCustoBloc ccustoBloc;
  const DashBoardPage({
    Key? key,
    required this.ccustoBloc,
  }) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late int _currentIndex = 0;
  late String ultimaSinc = '';
  late VendasBloc vendasBloc;

  @override
  void initState() {
    super.initState();
    Modular.to.pushNamed('./vendas/');

    vendasBloc = Modular.get<VendasBloc>();
  }

  void confirmarSair() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(bottom: 15, top: 20, right: 20, left: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/sair.svg',
                height: context.screenHeight * .2,
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
                        final localStorage = Modular.get<ILocalStorage>();

                        await localStorage.removeData('CNPJ');
                        await localStorage.removeData('LICENCA');
                        await localStorage.removeData('logado');

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
          context.screenWidth,
          height +
              (Platform.isWindows
                  ? 65
                  : Platform.isIOS
                      ? 40
                      : 60),
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
              top: (Platform.isWindows ? 60 : 75),
              left: 20.0,
              right: 20.0,
              child: DropDownWidget(
                ccustoBloc: widget.ccustoBloc,
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height + 10),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: RouterOutlet(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<VendasBloc, VendasStates>(
              bloc: vendasBloc,
              builder: (context, state) {
                if (state is! VendasSuccessState) {
                  return LoadingWidget(
                    size: Size(context.screenWidth * .5, 20),
                    radius: 10,
                  );
                }

                return Text(
                  'Ultima sincronização: ${Global.ultimaSinc.DiaMesAnoHora()}',
                );
              },
            ),
            const SizedBox(height: 10),
            CurvedNavigationBar(
              index: _currentIndex,
              color: AppTheme.colors.primary,
              backgroundColor: Colors.white,
              height: 60,
              items: [
                Icon(
                  _currentIndex == 0
                      ? Icons.attach_money_rounded
                      : Icons.attach_money_outlined,
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
                  _currentIndex == 4
                      ? Icons.call_made
                      : Icons.call_made_rounded,
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

                DashBoardController.navigation(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
