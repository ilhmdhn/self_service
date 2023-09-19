import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/fnb_page/fnb_list_page.dart';
import 'package:self_service/page/invoice_page/billing_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/util/order_args.dart';

class FnBOrderOfferingPage extends StatelessWidget {
  const FnBOrderOfferingPage({super.key});

  static const nameRoute = '/fnb-offering-page';
  @override
  Widget build(BuildContext context) {
  OrderArgs orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, orderArgs);
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(
                  'assets/images/background_fnb_offering.jpg',
                  width: double.infinity,
                  height: double.infinity,
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
                                            Navigator.pushNamedAndRemoveUntil(
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
            ),
            Positioned(
              bottom: 240,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, FnbListPage.nameRoute, arguments: orderArgs).then((argumenKembali) {
                        orderArgs = argumenKembali as OrderArgs;
                      });
                      },
                      style: CustomButtonStyle.buttonStyleDarkBlue(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Text(
                          "PESAN MAKAN & MINUM",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ),
              ),
            ),
            Positioned(
                right: 28,
                bottom: 28,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, BillingPage.nameRoute, arguments: orderArgs).then((argumenKembali) {
                        orderArgs = argumenKembali as OrderArgs;
                      });
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
          ],
        ),
      ),
    );
  }
}
