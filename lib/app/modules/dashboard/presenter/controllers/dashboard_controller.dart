import 'package:adm_bi/app/components/drop_down_widget/presenter/bloc/ccusto_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/presenter/blocs/contas_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/contas/presenter/blocs/events/contas_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/presenter/blocs/cp_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cp/presenter/blocs/events/cp_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/presenter/blocs/cr_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/cr/presenter/blocs/events/cr_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/estoque/presenter/blocs/estoque_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/estoque/presenter/blocs/events/estoque_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/events/formas_pag_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/resumo_formas/presenter/blocs/formas_pag_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/grafico_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/projecao_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/events/vendas_events.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/grafico_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/projecao_bloc.dart';
import 'package:adm_bi/app/modules/dashboard/submodules/vendas/presenter/bloc/vendas_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashBoardController {
  static navigation(int index) {
    final ccusto = Modular.get<CCustoBloc>().state.selectedEmpresa;

    if (index == 0) {
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
    if (index == 1) {
      if (Modular.get<ContasBloc>().state.filtredList.isEmpty) {
        Modular.get<ContasBloc>().add(GetContasEvent());
      } else {
        Modular.get<ContasBloc>().add(
          ContasFilterEvent(
            ccusto: ccusto,
            diaSemanaMes: 'Dia',
          ),
        );
      }
      Modular.to.pushReplacementNamed('../contas/');
    }
    if (index == 2) {
      if (Modular.get<FormasPagBloc>().state.filtredList.isEmpty) {
        Modular.get<FormasPagBloc>().add(GetFormasPagEvent());
      } else {
        Modular.get<FormasPagBloc>().add(FilterFormasPag(ccusto: ccusto));
      }
      Modular.to.pushReplacementNamed('../resumo_fp/');
    }
    if (index == 3) {
      if (Modular.get<CRBloc>().state.filtredList.isEmpty) {
        Modular.get<CRBloc>().add(GetCREvent());
      } else {
        Modular.get<CRBloc>().add(CRFilterEvent(ccusto: ccusto, filtro: ''));
      }
      Modular.to.pushReplacementNamed('../cr/');
    }
    if (index == 4) {
      if (Modular.get<CPBloc>().state.filtredList.isEmpty) {
        Modular.get<CPBloc>().add(GetCPEvent());
      } else {
        Modular.get<CPBloc>().add(CPFilterEvent(ccusto: ccusto, filtro: ''));
      }
      Modular.to.pushReplacementNamed('../cp/');
    }
    if (index == 5) {
      if (Modular.get<EstoqueBloc>().state.filtredList.isEmpty) {
        Modular.get<EstoqueBloc>().add(GetEstoqueMinimoEvent());
      } else {
        Modular.get<EstoqueBloc>()
            .add(EstoqueFilterEvent(ccusto: ccusto, filtro: ''));
      }
      Modular.to.pushReplacementNamed('../estoque/');
    }
  }
}
