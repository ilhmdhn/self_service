import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/data/model/pricing_model.dart';
import 'package:self_service/page/payment_page/payment_list_page.dart';
import 'package:self_service/page/payment_page/payment_page.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/page/style/text_style.dart';
import 'package:self_service/util/calculate_order.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';
import 'package:self_service/data/model/voucher_model.dart';

class BillingPage extends StatelessWidget {
  const BillingPage({super.key});

  static const nameRoute = '/billing-page';
  @override
  Widget build(BuildContext context) {
    CheckinArgs checkinArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinArgs;

    final ScrollController scrollController = ScrollController();
    final TaxServiceCubit taxServiceCubit = TaxServiceCubit();
    final PaymentMethodCubit paymentMethodCubit = PaymentMethodCubit();
    paymentMethodCubit.setData(PaymentMethodArgs(
      paymentMethod: checkinArgs.payment?.paymentMethod,
      paymentChannel: checkinArgs.payment?.paymentChannel,
      fee: checkinArgs.payment?.fee,
      name: checkinArgs.payment?.name
    ));

    taxServiceCubit.getData();
    num roomPrice = 0;
    num fnbPrice = 0;
    num servicePrice = 0;
    num taxPrice = 0;
    num checkinPrice = 0;
    num paymentPrice = 0;
    num priceTotal = 0;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, checkinArgs);
        return true;
      },
      child: Scaffold(
          backgroundColor: CustomColorStyle.lightBlue(),
          body: BlocBuilder<TaxServiceCubit, ServiceTaxResult>(
            bloc: taxServiceCubit,
            builder: (context, taxServiceState) {
              if (taxServiceState.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (taxServiceState.state != true ||
                  taxServiceState.detail == null) {
                return Center(
                  child: Text(taxServiceState.message ?? ''),
                );
              }

              checkinArgs.orderArgs?.fnb.servicePercent =
                  taxServiceState.detail?.serviceFnb ?? 0;
              checkinArgs.orderArgs?.fnb.taxPercent =
                  taxServiceState.detail?.taxFnb ?? 0;
              checkinArgs.roomPrice?.servicePercent =
                  taxServiceState.detail?.serviceRoom ?? 0;
              checkinArgs.roomPrice?.taxPercent =
                  taxServiceState.detail?.taxRoom ?? 0;

              checkinArgs = calculateOrder(checkinArgs);

              roomPrice = checkinArgs.roomPrice?.roomPrice ?? 0;
              fnbPrice = checkinArgs.orderArgs?.fnb.fnbTotal ?? 0;
              servicePrice = (checkinArgs.roomPrice?.serviceRoom ?? 0) +
                  (checkinArgs.orderArgs?.fnb.fnbService ?? 0);
              taxPrice = (checkinArgs.roomPrice?.taxRoom ?? 0) +
                  (checkinArgs.orderArgs?.fnb.fnbTax ?? 0);
              checkinPrice = roomPrice + fnbPrice + servicePrice + taxPrice;

              return Column(
                mainAxisSize: MainAxisSize.max,
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
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Column(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          checkinArgs.orderArgs?.memberName ??
                                              '',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(Currency.toRupiah(roomPrice),
                                          style: FontBilling.textBilling())),
                                ],
                              ),
                            ],
                          ),
                        ),
                        (checkinArgs.orderArgs?.fnb.fnbList ?? []).isNotEmpty
                            ? Column(
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
                                  Container(
                                    constraints:
                                        const BoxConstraints(maxHeight: 285),
                                    child: RawScrollbar(
                                      // isAlwaysShown: true,
                                      thumbVisibility: true,
                                      thickness: 2.5,
                                      trackVisibility: true,
                                      trackColor: Colors.grey.shade300,
                                      thumbColor:
                                          CustomColorStyle.bluePrimary(),
                                      controller: scrollController,
                                      child: ListView.builder(
                                          // scrollDirection: Axis.vertical, // Atur ke Axis.horizontal jika ingin scrollbar horizontal
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount: checkinArgs.orderArgs?.fnb
                                                  .fnbList.length ??
                                              0,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                                        ?.fnb
                                                                        .fnbList[
                                                                            index]
                                                                        .qty ==
                                                                    1
                                                                ? '${checkinArgs.orderArgs?.fnb.fnbList[index].itemName}'
                                                                : '${checkinArgs.orderArgs?.fnb.fnbList[index].qty}x ${checkinArgs.orderArgs?.fnb.fnbList[index].itemName}',
                                                            style: FontBilling
                                                                .textBilling())),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4),
                                                      child: Text(':',
                                                          style: FontBilling
                                                              .textBilling()),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                            Currency.toRupiah((checkinArgs
                                                                        .orderArgs
                                                                        ?.fnb
                                                                        .fnbList[
                                                                            index]
                                                                        .price ??
                                                                    0) *
                                                                (checkinArgs
                                                                        .orderArgs
                                                                        ?.fnb
                                                                        .fnbList[
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
                                ],
                              )

                            //fnb empty
                            : const SizedBox(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text('Service',
                                          style: FontBilling.textBilling())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          Currency.toRupiah(servicePrice),
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
                                      child: Text('Tax',
                                          style: FontBilling.textBilling())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(Currency.toRupiah(taxPrice),
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
                                      child: Text('Total',
                                          style: FontBilling.textBilling())),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Text(':',
                                        style: FontBilling.textBilling()),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          Currency.toRupiah(checkinPrice),
                                          style: FontBilling.textBilling())),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  BlocBuilder<PaymentMethodCubit, PaymentMethodArgs>(
                    bloc: paymentMethodCubit,
                    builder: (context, paymentMethodState) {
                      paymentPrice = paymentMethodState.fee ?? 0;
                      priceTotal = checkinPrice + paymentPrice;

                      return Padding(
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
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.monetization_on_outlined,
                                        color: CustomColorStyle.darkBlue(),
                                        size: 19),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'Promo',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13),
                                          )),
                                          const Expanded(
                                              child: AutoSizeText(''))
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  showVoucherDialog(context, '');
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.discount,
                                        color: CustomColorStyle.darkBlue(),
                                        size: 19),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'Voucher',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13),
                                          )),
                                          const Expanded(
                                              child: AutoSizeText(''))
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                          PaymentMethodListPage.nameRoute,
                                          arguments: checkinPrice)
                                      .then((value) {
                                    if (value != null) {
                                      value as PaymentMethodArgs;

                                      paymentMethodCubit.setData(value);
                                      checkinArgs.payment = PaymentMethodArgs(
                                        paymentMethod: value.paymentMethod,
                                        paymentChannel: value.paymentChannel,
                                        name: value.name,
                                        fee: value.fee,
                                        icon: value.icon,
                                      );
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.payment,
                                        color: CustomColorStyle.darkBlue(),
                                        size: 19),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Expanded(
                                              child: Text(
                                            'Metode Pembayaran',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 13),
                                          )),
                                          Expanded(
                                              child: AutoSizeText(
                                            paymentMethodState.name != null
                                                ? paymentMethodState.name!
                                                : '',
                                            textAlign: TextAlign.end,
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 14,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            paymentMethodState.fee != null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Biaya transfer',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        Currency.toRupiah(
                                            paymentMethodState.fee),
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  Currency.toRupiah(priceTotal),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                          context, PaymentPage.nameRoute,
                                          arguments: checkinArgs)
                                      .then((value) =>
                                          checkinArgs = value as CheckinArgs);
                                },
                                style: CustomButtonStyle.buttonStyleDarkBlue(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 31, vertical: 5),
                                  child: Text(
                                    'BAYAR',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              );
            },
          )),
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
