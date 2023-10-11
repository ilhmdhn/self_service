import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/member_model.dart';
import 'package:self_service/page/invoice_page/slip_checkin_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/util/tools.dart';

class ScanClubPage extends StatefulWidget {
  const ScanClubPage({super.key});

  static const nameRoute = '/scan-club-page';

  @override
  State<ScanClubPage> createState() => ScanClubPageState();
}

class ScanClubPageState extends State<ScanClubPage> {
  BoolCubit isLoadingCubit = BoolCubit();
  TextEditingController tvMemberCodeController = TextEditingController();
  MemberResult memberData = MemberResult();
  bool isLoading = false;
  final FocusNode _focusNode = FocusNode();
  OrderArgs orderArgs = OrderArgs();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, orderArgs);
        return false;
      },
      child: Scaffold(
          backgroundColor: CustomColorStyle.lightBlue(),
          body: Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context, orderArgs);
                        },
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 29,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text('Batalkan Transaksi?')),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Tidak')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        SplashPage.nameRoute,
                                                        (route) => false);
                                              },
                                              child: const Text('Iya'))
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: Image.asset('assets/icon/home.png'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'SILAHKAN PINDAI\nKODE QR',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'MEMBER PUPPY CLUB',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text(
                        'DI MESIN PEMINDAI',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/icon/scan_qr_illustration.png',
                          width: 256,
                          height: 256,
                        ),
                      ),
                      Text(
                        'UNTUK CHECK-IN\nSEBEGAI MEMBER',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: Column(
                      children: [
                        Text(
                          'jika mengalami kesulitan dalam scan kode qr',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dapat input manual ',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext contextDialog) {
                                      return AlertDialog(
                                        title: Center(
                                          child: Text(
                                            'Masukkan kode member',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16),
                                          ),
                                        ),
                                        content: SizedBox(
                                          height: 120,
                                          child: Column(
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  // fillColor: CustomColorStyle
                                                  //     .darkGrey(), // Latar belakang abu-abu
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0), // Sudut melengkung
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors
                                                          .red, // Warna garis tepi
                                                      width:
                                                          0.4, // Ketebalan garis tepi
                                                    ), // Tidak ada garis tepi
                                                  ),
                                                ),
                                                controller:
                                                    tvMemberCodeController,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              ElevatedButton(
                                                  style: CustomButtonStyle
                                                      .styleDarkBlueButton(),
                                                  onPressed: () async {
                                                    Navigator.pop(contextDialog);
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    memberData = await ApiService()
                                                        .getMember(
                                                            tvMemberCodeController
                                                                .text);

                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                    if (memberData.state ==
                                                        true) {
                                                      orderArgs.memberName =
                                                          memberData.data
                                                                  ?.memberName ??
                                                              '';
                                                      orderArgs.memberCode =
                                                          memberData.data
                                                                  ?.memberCode ??
                                                              '';

                                                      if (context.mounted) {
                                                        Navigator.pushNamed(context, SlipCheckinPage.nameRoute, arguments: orderArgs).then((value) =>orderArgs = value as OrderArgs);
                                                      }
                                                    } else {
                                                      showToastWarning(
                                                          memberData.message
                                                              .toString());
                                                    }
                                                  },
                                                  child: const Text('LOGIN'))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                'disini',
                                style: GoogleFonts.poppins(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 8,
                  ))
                : const Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 0,
                      width: 0,
                    ),
                  ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: RawKeyboardListener(
                focusNode: _focusNode,
                onKey: (RawKeyEvent event) async {
                  if (event.runtimeType == RawKeyUpEvent) {
                    final keyData = event.data;
                    if (keyData is RawKeyEventDataAndroid) {
                      setState(() {
                        isLoading = true;
                      });
                      memberData = await ApiService()
                          .getMember(tvMemberCodeController.text);
                      setState(() {
                        isLoading = false;
                      });
                      if (memberData.state == true) {
                        orderArgs.memberName =
                            memberData.data?.memberName ?? '';
                        orderArgs.memberCode =
                            memberData.data?.memberCode ?? '';
                        if (context.mounted) {
                          Navigator.pushNamed(
                                  context, SlipCheckinPage.nameRoute,
                                  arguments: orderArgs)
                              .then((value) => orderArgs = value as OrderArgs);
                        }
                      } else {
                        showToastWarning(
                            '${keyData.keyLabel} ${memberData.message}');
                      }

                      setState(() {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      });
                    }
                  }
                },
                child: const SizedBox(
                  height: 0,
                  width: 0,
                ),
              ),
            ),
          ])),
    );
  }
}
