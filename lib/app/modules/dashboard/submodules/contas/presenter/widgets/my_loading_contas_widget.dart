import 'package:adm_bi/app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/loading_widget.dart';

class MyLoadingContasWidget extends StatelessWidget {
  const MyLoadingContasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 8,
          child: Container(
            alignment: Alignment.center,
            width: context.screenWidth,
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                LoadingWidget(
                  size: Size(0, 0),
                  radius: 10,
                ),
                LoadingWidget(
                  size: Size(0, 0),
                  radius: 10,
                ),
                LoadingWidget(
                  size: Size(0, 0),
                  radius: 10,
                ),
                LoadingWidget(
                  size: Size(0, 0),
                  radius: 10,
                ),
                LoadingWidget(
                  size: Size(0, 0),
                  radius: 10,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 2,
          child: Row(
            children: const [
              Expanded(
                child: LoadingWidget(
                  size: Size(0, 100),
                  radius: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
