import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/invoice_page/slip_checkin_page.dart';
import 'package:self_service/page/register_puppy_club/login_club_page.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/style/text_style.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/util/tools.dart';

class RegisterClubPage extends StatelessWidget {
  const RegisterClubPage({super.key});
  static const nameRoute = '/room-club-register-page';

  @override
  Widget build(BuildContext context) {
    TextEditingController tfNameController = TextEditingController();
    OrderArgs orderArgs =
        ModalRoute.of(context)!.settings.arguments as OrderArgs;
    return WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/background_club_register.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ScanClubPage.nameRoute,
                                    arguments: orderArgs)
                                .then(
                                    (value) => orderArgs = value as OrderArgs);
                          },
                          style:
                              CustomButtonStyle.buttonStyleRoundedBlueTrans(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(
                              "SUDAH",
                              style: GoogleFonts.poppins(
                                  color: CustomColorStyle.darkBlue(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                      const SizedBox(
                        width: 23,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: CustomButtonStyle.buttonStyleDarkBlue(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Text(
                              "DAFTAR",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                    ],
                  )),
              Positioned(
                  right: 28,
                  bottom: 28,
                  child: InkWell(
                    onTap: () async {
                      final validName = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(
                                child: Text(
                                  'Nama Pengunjung',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              content: SizedBox(
                                height: 120,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextField(
                                      controller: tfNameController,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          style: CustomButtonStyle
                                              .styleDarkBlueButton(),
                                          onPressed: () {
                                            if (tfNameController.text.isEmpty) {
                                              showToastWarning(
                                                  'Nama tidak boleh kosong');
                                            } else {
                                              orderArgs.memberName =
                                                  tfNameController.text
                                                      .toUpperCase();
                                              orderArgs.memberCode =
                                                  tfNameController.text
                                                      .toUpperCase();
                                              Navigator.pop(context, true);
                                            }
                                          },
                                          child: Text(
                                            'Lanjut',
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                      if (validName == true) {
                        if (context.mounted) {
                          Navigator.pushNamed(
                                  context, SlipCheckinPage.nameRoute,
                                  arguments: orderArgs)
                              .then((argumenKembali) {
                            orderArgs = argumenKembali as OrderArgs;
                          });
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SKIP",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                            width: 17,
                            height: 17,
                            child: Image.asset(
                              'assets/icon/next.png',
                            )),
                      ],
                    ),
                  )),
              Positioned(
                top: 6,
                left: 7,
                right: 7,
                child: Row(
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
                                  title: Center(
                                    child: Text('Batalkan Transaksi?', style: CustomTextStyle.titleAlertDialog(),)),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: CustomButtonStyle.cancel(),
                                          child: Text('Tidak', style: CustomTextStyle.cancel(),)),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  SplashPage.nameRoute,
                                                  (route) => false);
                                            },
                                            style: CustomButtonStyle.confirm(),
                                            child: Text('Iya', style: CustomTextStyle.confirm(),))
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
              ),
            ],
          ),
        ),
        onWillPop: () async {
          Navigator.pop(context, orderArgs);
          return false;
        });
  }
}
