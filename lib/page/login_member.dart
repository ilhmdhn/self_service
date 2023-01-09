import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_service/bloc/input_bloc.dart';
import 'package:self_service/bloc/member_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/member_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final InputCubit inputCubit = InputCubit();
  final inputCode = TextEditingController();
  final MemberCubit memberCubit = MemberCubit();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CheckinData checkinData = CheckinData(
      checkinInfo: CheckinInfo(), fnbInfo: FnBInfo(), promoInfo: PromoInfo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        BlocBuilder<MemberCubit, MemberResult>(
          bloc: memberCubit,
          builder: (context, memberState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (memberState.isLoading == false) {
                if (memberState.state == true) {
                  checkinData.checkinInfo.memberCode =
                      memberState.data?.memberCode;
                  checkinData.checkinInfo.memberName =
                      memberState.data?.memberName;
                  Navigator.pushNamed(context, '/room-category',
                      arguments: checkinData);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(memberState.message.toString()),
                  ));
                }
              } // Add Your Code here.
            });

            return const SizedBox();
          },
        ),
        const Expanded(
            child: Text('Sudah terdaftar sebagai member Puppy Club?',
                style: TextStyle(fontSize: 23))),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    Navigator.of(context).pop(inputCode.text);
                                    // Navigator.pop(context, inputCode.text);
                                  }
                                },
                                child: const Text('OK')),
                          ],
                        )).then((value) {
                  if (value != null) {
                    memberCubit.getData(value);
                  }
                });
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.red),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/splash', (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.lime.shade800),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Kembali',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                ],
              ),
            )
          ],
        ))
      ]),
    );
  }
}
