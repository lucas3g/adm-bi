import 'package:app_demonstrativo/app/components/my_input_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';

class CRPage extends StatefulWidget {
  const CRPage({Key? key}) : super(key: key);

  @override
  State<CRPage> createState() => _CRPageState();
}

class _CRPageState extends State<CRPage> {
  final fPesquisa = FocusNode();
  final pesquisaController = TextEditingController();
  final gkPesquisa = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyInputWidget(
            focusNode: fPesquisa,
            hintText: 'Digite o nome do cliente',
            label: 'Pesquisa',
            textEditingController: pesquisaController,
            formKey: gkPesquisa,
            inputFormaters: [
              UpperCaseTextFormatter(),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Geral',
                  style: AppTheme.textStyles.titleTotalGeralCRCP,
                ),
                Text(
                  'R\$ 150.505,50',
                  style: AppTheme.textStyles.totalGeralClienteCRCP,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: Text('Lucas Silva'),
                        ),
                        Text(
                          'R\$ 5.950,58',
                          style: AppTheme.textStyles.saldoClienteCRCP,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
