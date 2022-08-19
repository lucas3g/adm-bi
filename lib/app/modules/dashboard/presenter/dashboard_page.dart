// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:app_demonstrativo/app/components/drop_down_widget/presenter/drop_down_widget.dart';
import 'package:app_demonstrativo/app/components/my_elevated_button_widget.dart';
import 'package:app_demonstrativo/app/components/my_title_app_bar_widget.dart';
import 'package:app_demonstrativo/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/contas_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/contas/presenter/blocs/events/contas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/cp_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cp/presenter/blocs/events/cp_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/presenter/blocs/estoque_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/estoque/presenter/blocs/events/estoque_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/events/formas_pag_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/formas_pag_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/grafico_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/projecao_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/grafico_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/projecao_bloc.dart';
import 'package:app_demonstrativo/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    Modular.to.pushNamed('./vendas/');
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
          MediaQuery.of(context).size.width,
          height + (Platform.isWindows ? 65 : 60),
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
              top: (Platform.isWindows ? 60 : 70),
              left: 20.0,
              right: 20.0,
              child: DropDownWidget(
                ccustoBloc: widget.ccustoBloc,
              ),
            )
          ],
        ),
      );

  navigation() {
    final ccusto = Modular.get<CCustoBloc>().state.selectedEmpresa;

    if (_currentIndex == 0) {
      if (Modular.get<VendasBloc>().state.filtredList.isEmpty) {
        Modular.get<VendasBloc>().add(GetVendasEvent());
      } else {
        Modular.get<VendasBloc>().add(VendasFilterEvent(ccusto: ccusto));
      }

      if (Modular.get<ProjecaoBloc>().state.filtredList.isEmpty) {
        Modular.get<ProjecaoBloc>().add(GetProjecaoEvent());
      } else {
        Modular.get<ProjecaoBloc>().add(ProjecaoFilterEvent(ccusto: ccusto));
      }

      if (Modular.get<GraficoBloc>().state.filtredList.isEmpty) {
        Modular.get<GraficoBloc>().add(GetGraficoEvent());
      } else {
        Modular.get<GraficoBloc>().add(GraficoFilterEvent(ccusto: ccusto));
      }

      Modular.to.pushReplacementNamed('../vendas/');
    }
    if (_currentIndex == 1) {
      if (Modular.get<ContasBloc>().state.filtredList.isEmpty) {
        Modular.get<ContasBloc>().add(GetContasEvent());
      } else {
        Modular.get<ContasBloc>().add(ContasFilterEvent(ccusto: ccusto));
      }
      Modular.to.pushReplacementNamed('../contas/');
    }
    if (_currentIndex == 2) {
      if (Modular.get<FormasPagBloc>().state.filtredList.isEmpty) {
        Modular.get<FormasPagBloc>().add(GetFormasPagEvent());
      } else {
        Modular.get<FormasPagBloc>().add(FilterFormasPag(ccusto: ccusto));
      }
      Modular.to.pushReplacementNamed('../resumo_fp/');
    }
    if (_currentIndex == 3) {
      if (Modular.get<CRBloc>().state.filtredList.isEmpty) {
        Modular.get<CRBloc>().add(GetCREvent());
      } else {
        Modular.get<CRBloc>().add(CRFilterEvent(ccusto: ccusto, filtro: ''));
      }
      Modular.to.pushReplacementNamed('../cr/');
    }
    if (_currentIndex == 4) {
      if (Modular.get<CPBloc>().state.filtredList.isEmpty) {
        Modular.get<CPBloc>().add(GetCPEvent());
      } else {
        Modular.get<CPBloc>().add(CPFilterEvent(ccusto: ccusto, filtro: ''));
      }
      Modular.to.pushReplacementNamed('../cp/');
    }
    if (_currentIndex == 5) {
      if (Modular.get<EstoqueBloc>().state.filtredList.isEmpty) {
        Modular.get<EstoqueBloc>().add(GetEstoqueMinimoEvent());
      } else {
        Modular.get<EstoqueBloc>()
            .add(EstoqueFilterEvent(ccusto: ccusto, filtro: ''));
      }
      Modular.to.pushReplacementNamed('../estoque/');
    }
  }

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
        child: CurvedNavigationBar(
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

            navigation();
          },
        ),
      ),
    );
  }
}
