import 'package:app_demonstrativo/app/components/my_input_widget.dart';
import 'package:app_demonstrativo/app/theme/app_theme.dart';
import 'package:app_demonstrativo/app/utils/formatters.dart';
import 'package:flutter/material.dart';

class CPPage extends StatefulWidget {
  const CPPage({Key? key}) : super(key: key);

  @override
  State<CPPage> createState() => _CPPageState();
}

class _CPPageState extends State<CPPage> {
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
            hintText: 'Digite o nome do fornecedor',
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
                          child: Text('AS Grãos'),
                        ),
                        Text(
                          'R\$ 65.950,58',
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
