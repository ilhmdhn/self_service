import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:slide_countdown/slide_countdown.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  static const nameRoute = '/payment-page';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    PaymentMethodArgs paymentMethod = PaymentMethodArgs(
        paymentMethod: 'qris',
        paymentChannel: 'qris',
        icon: 'https://adm.happypuppy.id/uploads/Icon/20231024021230.png');

    // PaymentMethodArgs paymentMethod = PaymentMethodArgs(paymentMethod: 'qris', paymentChannel: 'qris', icon: 'https://adm.happypuppy.id/uploads/Icon/20231024021501.png');

    return Scaffold(
      backgroundColor: CustomColorStyle.lightBlue(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 11,
                            ),
                            Text(
                              'Bayar Sebelum',
                              style: GoogleFonts.poppins(fontSize: 15),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 90),
                            //   child: Container(
                            //     height: 0.7,
                            //     color: Colors.grey,
                            //   ),
                            // ),
                            Text(
                              '19 Maret 2023 19:30:00',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SlideCountdownSeparated(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColorStyle().hexToColor('#e5f1fd'),
                        ),
                        duration: const Duration(minutes: 10),
                        separatorType: SeparatorType.symbol,
                        padding: const EdgeInsets.all(7),
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                        // separatorStyle: GoogleFonts.poppins(
                        //     fontSize: 12,
                        //     color: Colors.redAccent,
                        //     fontWeight: FontWeight.w500),
                        // durationTitle: const DurationTitle(
                        //     days: 'hari',
                        //     hours: 'jam',
                        //     minutes: 'menit',
                        //     seconds: 'detik'),
                      )
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              paymentMethod.paymentMethod == 'va'
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://adm.happypuppy.id/uploads/Icon/20231024021230.png',
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bank BCA',
                                    style: GoogleFonts.poppins(fontSize: 13),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 0.7,
                                    color: Colors.grey,
                                  ),
                                  Text('No Virtual Account',
                                      style: GoogleFonts.poppins(fontSize: 12)),
                                  Text('215r326478328163726872988675467',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.redAccent)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : paymentMethod.paymentMethod == 'qris'
                      ? Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: CustomColorStyle.blueQrisBg(),
                              borderRadius: BorderRadius.circular(26)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/icon/payment/qris.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                        Image.asset(
                                          'assets/icon/payment/gpn.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    Text(
                                      'PT Imperium Happy Puppy',
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'NMID: 123032493585349320294358',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(19)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: QrImageView(
                                          data:
                                              '00020101021226670016COM.NOBUBANK.WWW01189360050300000488870214041800000314060303UMI51440014ID.CO.QRIS.WWW0215ID20200814001730303UMI520454995303360540710070005802ID5906iPaymu6008Denpasar61051581162810114102700002588050520202310271405204915060620202310271405204915060703A010804POSP6304D890',
                                          size: 235,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                          Text(Currency.toRupiah(1000000),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                        height: 0.7,
                                        width: double.infinity,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Dapat dibayar menggunakan',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icon/payment/bca.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/bri.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/mandiri.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/bni.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/bsi.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/danamon.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/dana.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/gopay.png',
                                            width: 25,
                                            height: 25,
                                          )
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icon/payment/linkaja.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/ovo.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 3),
                                          Image.asset(
                                            'assets/icon/payment/shopeepay.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'etc.',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      CustomColorStyle()
                                                          .hexToColor(
                                                              '#24accc'),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              225.0)),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  'Ubah Pembayaran',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                                style: CustomButtonStyle
                                                    .buttonStyleDarkBlue(),
                                                onPressed: () {},
                                                child: Text(
                                                  'Selesai',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
