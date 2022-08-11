// ignore_for_file: depend_on_referenced_packages

import 'package:app_demonstrativo/app/app_module.dart';
import 'package:app_demonstrativo/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';

Future<void> main() async {
  await initializeDateFormatting(await findSystemLocale(), '');

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
