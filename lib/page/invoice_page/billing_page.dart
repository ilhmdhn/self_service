import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/style/text_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';
import 'package:self_service/data/model/voucher_model.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  static const nameRoute = '/billing-page';
  @override
  Widget build(BuildContext context) {
    final checkinArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinArgs;
    final ScrollController scrollController = ScrollController();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, checkinArgs.orderArgs);
        return true;
      },
      child: Scaffold(
        backgroundColor: CustomColorStyle.lightBlue(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, checkinArgs);
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Billing',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
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
                                child: Text(
                                    checkinArgs.orderArgs?.roomCode ?? '',
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        //space height
                        const SizedBox(
                          height: 3,
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
                                child: Text(
                                    checkinArgs.orderArgs?.memberName ?? '',
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        //space height
                        const SizedBox(
                          height: 3,
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
                                child: Text(
                                    '${checkinArgs.orderArgs?.checkinDuration} JAM',
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        //space height
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Harga Room',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    Currency.toRupiah(
                                        checkinArgs.roomPrice?.roomPrice),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        //space height
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Service Room',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    Currency.toRupiah(
                                        checkinArgs.roomPrice?.serviceRoom),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        //space height
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Tax Room',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    Currency.toRupiah(
                                        checkinArgs.roomPrice?.taxRoom ?? 0),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                        //space height
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Text('Total harga room',
                                    style: FontBilling.textBilling())),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child:
                                  Text(':', style: FontBilling.textBilling()),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                    Currency.toRupiah(
                                        checkinArgs.roomPrice?.priceTotal ?? 0),
                                    style: FontBilling.textBilling())),
                          ],
                        ),
                      ],
                    ),
                  ),
                  (checkinArgs.orderArgs?.fnb.fnbList ?? []).isNotEmpty
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Food and Beverages:',
                                style: FontBilling.textBilling(),
                              ),
                              Expanded(
                                child: RawScrollbar(
                                  // isAlwaysShown: true,
                                  thumbVisibility: true,
                                  thickness: 2.5,
                                  trackVisibility: true,
                                  trackColor: Colors.grey.shade300,
                                  thumbColor: CustomColorStyle.bluePrimary(),
                                  controller: scrollController,
                                  child: ListView.builder(
                                      // scrollDirection: Axis.vertical, // Atur ke Axis.horizontal jika ingin scrollbar horizontal
                                      controller: scrollController,
                                      itemCount:
                                          checkinArgs.orderArgs?.fnb.fnbList.length ??
                                              0,
                                      itemBuilder: (context, index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1.8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        checkinArgs
                                                                    .orderArgs
                                                                    ?.fnb.fnbList[index]
                                                                    .qty ==
                                                                1
                                                            ? '${checkinArgs.orderArgs?.fnb.fnbList[index].itemName}'
                                                            : '${checkinArgs.orderArgs?.fnb.fnbList[index].qty}x ${checkinArgs.orderArgs?.fnb.fnbList[index].itemName}',
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
                                                        Currency.toRupiah(checkinArgs
                                                                .orderArgs
                                                                ?.fnb.fnbList[index]
                                                                .price ??
                                                            0 *
                                                                (checkinArgs
                                                                        .orderArgs
                                                                        ?.fnb.fnbList[
                                                                            index]
                                                                        .qty ??
                                                                    0)),
                                                        style: FontBilling
                                                            .textBilling())),
                                              ],
                                            ),
                                          )),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text('Service FnB',
                                          style: FontBilling.textBilling())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(Currency.toRupiah(1210000),
                                          style: FontBilling.textBilling())),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text('Tax FnB',
                                          style: FontBilling.textBilling())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(Currency.toRupiah(12100000),
                                          style: FontBilling.textBilling())),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text('Total FnB',
                                          style: FontBilling.textBilling())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(Currency.toRupiah(12100000),
                                          style: FontBilling.textBilling())),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Expanded(child: Container()),
                  SizedBox(
                    height: 135,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Promo',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 35,
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
                                    size: 16,
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
                                    size: 21,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Voucher',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        InkWell(
                          onTap: () {
                            showVoucherDialog(context, '');
                          },
                          child: Container(
                            height: 35,
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
                                      size: 16,
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
                                      size: 21,
                                    )
                                  ],
                                ),
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

  void showVoucherDialog(BuildContext context, String memberCOde) {
    VoucherCubit voucherCubit = VoucherCubit();
    voucherCubit.setData(memberCOde);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: BlocBuilder<VoucherCubit, VoucherDataResult>(
                  bloc: voucherCubit,
                  builder: (context, voucherResult) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Container(
                          decoration: BoxDecoration(
                              color: CustomColorStyle.lightBlue(),
                              borderRadius: BorderRadius.circular(20)),
                          child: voucherResult.isLoading == true
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : voucherResult.state == false
                                  ? Center(
                                      child: Text(
                                        voucherResult.message.toString(),
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                    )
                                  : voucherResult.voucherData == null ||
                                          (voucherResult.voucherData ??
                                                  List.empty())
                                              .isEmpty
                                      ? Center(
                                          child: Text(
                                            'Tidak memiliki voucher',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView.builder(
                                              itemCount: voucherResult
                                                  .voucherData?.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    CachedNetworkImage(
                                                        imageUrl:
                                                            'https://adm.happypuppy.id/${voucherResult.voucherData?[index].image}'),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          voucherResult
                                                              .voucherData![
                                                                  index]
                                                              .voucherName
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    contentPadding: const EdgeInsets
                                                                            .only(
                                                                        left: 6,
                                                                        right:
                                                                            6,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    content:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.6,
                                                                      child:
                                                                          Expanded(
                                                                        child: Column(
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.topRight,
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Icon(Icons.close),
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                child: SingleChildScrollView(
                                                                                  child: HtmlWidget(voucherResult.voucherData?[index].description ?? ''),
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: Icon(
                                                            Icons.info_outline,
                                                            color:
                                                                CustomColorStyle
                                                                    .darkBlue(),
                                                            size: 20,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                );
                                              }),
                                        )),
                    );
                  }));
        });
  }
}
