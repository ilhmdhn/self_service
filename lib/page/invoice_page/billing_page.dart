import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/style/text_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  static const nameRoute = '/billing-page';
  @override
  Widget build(BuildContext context) {
    final orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, orderArgs);
        return true;
      },
      child: Scaffold(
        backgroundColor: CustomColorStyle.lightBlue(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 55,
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
                  Text(
                    'Billing',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 21),
                    textAlign: TextAlign.left,
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Ruangan',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text('Party A',
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Member',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text('Ilham Dohaan',
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Durasi',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text('2 Jam',
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Tarif',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(Currency.toRupiah(1000000),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Service',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(Currency.toRupiah(100000),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Tax',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(Currency.toRupiah(110000),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Total Ruangan',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(Currency.toRupiah(1210000),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                      ],
                    ),
                  ),
                  orderArgs.fnb.isNotEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Food and Beverages',
                                style: FontBilling.textBilling(),
                              ),
                              Expanded(
                                child: Scrollbar(
                                  child: ListView.builder(
                                      scrollDirection: Axis
                                          .vertical, // Atur ke Axis.horizontal jika ingin scrollbar horizontal
                                      controller: ScrollController(),
                                      itemCount: orderArgs.fnb.length,
                                      itemBuilder: (context, index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        orderArgs.fnb[index]
                                                                    .qty ==
                                                                1
                                                            ? '${orderArgs.fnb[index].itemName}'
                                                            : '${orderArgs.fnb[index].qty}x ${orderArgs.fnb[index].itemName}',
                                                        style: FontBilling
                                                            .textBilling())),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  child: Text(':',
                                                      style: FontBilling
                                                          .textBilling()),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                        Currency.toRupiah(
                                                            orderArgs.fnb[index]
                                                                    .price *
                                                                orderArgs
                                                                    .fnb[index]
                                                                    .qty),
                                                        style: FontBilling
                                                            .textBilling())),
                                              ],
                                            ),
                                          )),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: 165,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Promo',
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue, width: 1.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.discount,
                                    color: Colors.green.shade600,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        'Pasang Promo untuk lebih hemat',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_sharp,
                                    color: CustomColorStyle.darkBlue(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Voucher',
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.blue, width: 1.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.card_giftcard,
                                    color: Colors.green.shade600,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        'Pilih Voucher',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_circle_right_sharp,
                                    color: CustomColorStyle.darkBlue(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
            SizedBox(
              height: 115,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '296.000',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, BillingPage.nameRoute);
                        },
                        style: CustomButtonStyle.buttonStyleDarkBlue(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 31, vertical: 5),
                          child: Text(
                            'BAYAR',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
