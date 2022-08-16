import 'package:app_demonstrativo/app/modules/dashboard/submodules/resumo_formas/domain/entities/formas_pag_entity.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';

// final List<Color> colors = [
//   const Color(0xFFba0000),
//   const Color(0xFFff5900),
//   const Color(0xFF54ba00),
//   const Color(0xFF00b1ba),
//   const Color(0xFF0019ba),
//   const Color(0xFFb400ba),
//   const Color(0xFFb7ba00),
//   const Color(0xFFba0000),
//   const Color(0xFFff5900),
//   const Color(0xFF54ba00),
//   const Color(0xFF00b1ba),
//   const Color(0xFF0019ba),
//   const Color(0xFFb400ba),
//   const Color(0xFFb7ba00),
// ];

class MyGraficoFormasPagWidget extends StatefulWidget {
  final FormasPag formasPag;
  const MyGraficoFormasPagWidget({
    Key? key,
    required this.formasPag,
  }) : super(key: key);

  @override
  State<MyGraficoFormasPagWidget> createState() =>
      _MyGraficoFormasPagWidgetState();
}

class _MyGraficoFormasPagWidgetState extends State<MyGraficoFormasPagWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(widget.formasPag.descricao.trim().capitalize),
      trailing: Text(
        widget.formasPag.totalForma.reais(),
        style: AppTheme.textStyles.valorResumoVendas,
      ),
    );

    // AspectRatio(
    //   aspectRatio: 1.3,
    //   child: Card(
    //     color: Colors.white,
    //     child: Row(
    //       children: <Widget>[
    //         const SizedBox(
    //           height: 18,
    //         ),
    //         Expanded(
    //           child: PieChart(
    //             PieChartData(
    //               pieTouchData: PieTouchData(
    //                   touchCallback: (FlTouchEvent event, pieTouchResponse) {
    //                 setState(() {
    //                   if (!event.isInterestedForInteractions ||
    //                       pieTouchResponse == null ||
    //                       pieTouchResponse.touchedSection == null) {
    //                     touchedIndex = -1;
    //                     return;
    //                   }
    //                   touchedIndex =
    //                       pieTouchResponse.touchedSection!.touchedSectionIndex;
    //                 });
    //               }),
    //               borderData: FlBorderData(
    //                 show: false,
    //               ),
    //               sectionsSpace: 0,
    //               centerSpaceRadius: 40,
    //               sections: showingSections(),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  // List<PieChartSectionData> showingSections() {
  //   return List.generate(
  //       widget.formasPag[widget.indexGrafico == 0 ? 'CR' : 'CP'].length, (i) {
  //     final isTouched = i == touchedIndex;
  //     final fontSize = isTouched ? 25.0 : 16.0;
  //     final radius = isTouched ? 60.0 : 50.0;

  //     final double total = widget
  //         .formasPag[widget.indexGrafico == 0 ? 'CR' : 'CP'][i].totalForma;

  //     final double perc = widget
  //         .formasPag[widget.indexGrafico == 0 ? 'CR' : 'CP'][i].percentual;

  //     return PieChartSectionData(
  //       color: colors[i],
  //       value: total,
  //       title: perc.round() > 10 ? '${perc.round()}%' : '',
  //       radius: radius,
  //       titleStyle: TextStyle(
  //         fontSize: fontSize,
  //         fontWeight: FontWeight.bold,
  //         color: const Color(0xffffffff),
  //       ),
  //     );
  //   });
  // }
}
