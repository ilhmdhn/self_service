import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/setting_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static const nameRoute = '/setting';

  @override
  Widget build(BuildContext context) {
    final BaseUrlCubit baseUrlCubit = BaseUrlCubit();
    TextEditingController url = TextEditingController();
    baseUrlCubit.getData();
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
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Base Url',
                            style: TextStyle(fontSize: 18),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: TextField(
                                  controller: url,
                                  keyboardType: TextInputType.number),
                            ),
                          ),
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () {
                        baseUrlCubit.setData(url.text);
                        baseUrlCubit.getData();
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
