import 'package:flutter/material.dart';

class FnBPage extends StatelessWidget {
  const FnBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon:const Icon(Icons.navigate_before)),
              ListView.builder(
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
              IconButton(onPressed: () {}, icon:const Icon(Icons.navigate_next))
            ],
          ),
        ],
      ),
    );
  }
}
