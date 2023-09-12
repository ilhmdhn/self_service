import 'package:flutter/material.dart';
import 'package:self_service/page/style/color_style.dart';

class FnbListPage extends StatefulWidget {
  const FnbListPage({super.key});

  @override
  State<FnbListPage> createState() => _FnbListPageState();
}

class _FnbListPageState extends State<FnbListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: Container(color: CustomColorStyle.bluePrimary(),)),
            Expanded(flex: 6, child: Container(color: CustomColorStyle.lightBlue(),))
          ],
        ),
        ],
      ),
    );
  }
}