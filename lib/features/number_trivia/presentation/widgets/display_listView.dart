import 'package:bloc_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_clean_architecture/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DisplayListView extends StatelessWidget {
  final List<NumberTrivia> listNumberTrivia;

  const DisplayListView({
    Key? key,
    required this.listNumberTrivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listNumberTrivia.length,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                logi.i(listNumberTrivia[index].text);
              },
              title: Text(listNumberTrivia[index].text),
            ),
          );
        });
  }
}
