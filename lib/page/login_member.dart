import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_service/bloc/input_bloc.dart';
import 'package:self_service/bloc/member_bloc.dart';
import 'package:self_service/data/model/member_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final InputCubit inputCubit = InputCubit();
  final inputCode = TextEditingController();
  final MemberCubit memberCubit = MemberCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<MemberCubit, MemberResult>(
                bloc: memberCubit,
                builder: (context, memberState) {
                  print('response' + memberState.message.toString());
                  if (memberState.isLoading == false) {
                    if (memberState.state == false) {
                      return SnackBar(
                          content: Text(memberState.message.toString()));
                    }
                    print('response' + memberState.message.toString());
                    SnackBar(content: Text(memberState.message.toString()));
                  }
                  return const SizedBox();
                }),
            const Text('Sudah terdaftar sebagai member Puppy Club?',
                style: TextStyle(fontSize: 23)),
            const Expanded(
              child: Text('azz'),
            )
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Expanded(
                child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Download Puppy Club App',
                        style: TextStyle(fontSize: 28)),
                    SvgPicture.asset('images/download_ilustration.svg')
                  ],
                ),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Masukkan kode member'),
                          content: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              // contentPadding: EdgeInsets.symmetric(vertical: 8),
                              hintText: 'kode member',
                            ),
                            controller: inputCode,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  if (inputCode.text.isNotEmpty) {
                                    memberCubit.getData(inputCode.text);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('OK')),
                          ],
                        ));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Login dengan kode member',
                        style: TextStyle(fontSize: 28)),
                    SvgPicture.asset(
                      'images/login_ilustration.svg',
                      height: 100,
                    )
                  ],
                ),
              ),
            )),
            Expanded(
                child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Checkin as guest',
                        style: TextStyle(fontSize: 28)),
                    SvgPicture.asset('images/guest_ilustration.svg')
                  ],
                ),
              ),
            )),
          ],
        ))
      ]),
    );
  }
}
