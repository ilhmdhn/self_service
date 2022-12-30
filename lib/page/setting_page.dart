import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/setting_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseUrlCubit baseUrlCubit = BaseUrlCubit();
    TextEditingController url = TextEditingController();
    String? insertUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<BaseUrlCubit, String>(
            bloc: baseUrlCubit,
            builder: (context, state) {
              url.text = state;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: url,
                    onChanged: (String value) {
                      insertUrl = value;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        baseUrlCubit.setData(insertUrl);
                      },
                      child: const Text('Submit'))
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
