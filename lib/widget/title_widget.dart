import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text("todos",
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: Colors.grey.shade800)),
    );
  }
}
