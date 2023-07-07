import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/bloc/member_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/member_model.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  static const nameRoute = '/login';

  final InputCubit inputCubit = InputCubit();
  final inputCode = TextEditingController();
  final MemberCubit memberCubit = MemberCubit();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CheckinData checkinData = CheckinData(
      checkinInfo: CheckinInfo(),
      fnbInfo: FnBInfo(),
      promoInfo: PromoInfo(),
      voucherInfo: VoucherInfo());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Login Page')),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(child: Text('Batalkan Transaksi?')),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tidak')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        SplashPage.nameRoute, (route) => false);
                                  },
                                  child: const Text('Iya'))
                            ],
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.home_outlined))
        ],
      ),
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
                  // Navigator.pushNamed(context, RoomCategoryPage.nameRoute,
                  //     arguments: checkinData);
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
            child: Center(
          child: Text('Sudah terdaftar sebagai member Puppy Club?',
              style: TextStyle(fontSize: 23)),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            content: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text('QR Code IOS'),
                              Text('QR Code Android'),
                            ],
                          ),
                        ));
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Expanded(
                        child: Text('Download Puppy Club App',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 21)),
                      ),
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
                      const Expanded(
                        child: Text('Login dengan kode member',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 21)),
                      ),
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
                      const Expanded(
                        child: Text('Checkin as guest',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 21)),
                      ),
                      SvgPicture.asset('images/guest_ilustration.svg')
                    ],
                  ),
                ),
              )),
            ],
          ),
        ))
      ]),
    );
  }
}
