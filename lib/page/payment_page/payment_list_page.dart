import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/data/model/list_payment.dart';
import 'package:self_service/page/payment_page/payment_bloc.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';

class PaymentMethodListPage extends StatefulWidget {
  const PaymentMethodListPage({super.key});
  static const nameRoute = '/list-payment';
  @override
  State<PaymentMethodListPage> createState() => _PaymentMethodListPageState();
}

class _PaymentMethodListPageState extends State<PaymentMethodListPage> {
  PaymentListCubit listPaymentCubit = PaymentListCubit();
  num totalBill = 0;
  PaymentMethodArgs? choosePaymentMethod;

  @override
  void initState() {
    listPaymentCubit.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    totalBill = ModalRoute.of(context)!.settings.arguments as num;
    return Scaffold(
      // backgroundColor: CustomColorStyle.lightBlue(),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 29,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Metode Pembayaran',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 21),
                ),
                const SizedBox(
                  height: 3,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocBuilder<PaymentListCubit, ListPaymentResult>(
                        bloc: listPaymentCubit,
                        builder: (context, stateListPayment) {
                          if (stateListPayment.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (stateListPayment.state == false) {
                            Center(
                              child: Text(stateListPayment.message ?? 'error'),
                            );
                          }
                          List<PaymentMethod> listPayment =
                              stateListPayment.data ?? [];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: ExpansionPanelList(
                                materialGapSize: 0,
                                expandedHeaderPadding: const EdgeInsets.all(0),
                                expansionCallback:
                                    (int index, bool isExpanded) {
                                  setState(() {
                                    stateListPayment.data?[index].isExpanded =
                                        !listPayment[index].isExpanded;
                                    listPaymentCubit
                                        .updateData(stateListPayment);
                                  });
                                },
                                children: listPayment
                                    .map<ExpansionPanel>((PaymentMethod item) {
                                  return ExpansionPanel(
                                      headerBuilder: (BuildContext context,
                                          bool isExpanded) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              int index =
                                                  listPayment.indexOf(item);
                                              stateListPayment
                                                      .data?[index].isExpanded =
                                                  !listPayment[index]
                                                      .isExpanded;
                                              listPaymentCubit
                                                  .updateData(stateListPayment);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: SizedBox(
                                              child: ListTile(
                                                title: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 50,
                                                      child: CachedNetworkImage(
                                                          imageUrl: item.icon
                                                              .toString()),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            item.name
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14)),
                                                        choosePaymentMethod !=
                                                                    null &&
                                                                choosePaymentMethod
                                                                        ?.paymentMethod ==
                                                                    item.code
                                                            ? Column(
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                    (choosePaymentMethod
                                                                            ?.name ??
                                                                        ''),
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            11,
                                                                        color: Colors
                                                                            .black),
                                                                  )
                                                                ],
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      body: SizedBox(
                                        height:
                                            ((item.channel?.length ?? 0) * 48)
                                                .toDouble(),
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                item.channel?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              String percent = '';
                                              num servicePayment = 0;
                                              String additionalService = '';
                                              if ((item.channel?[index].fee
                                                          ?.actualFee ??
                                                      0) >
                                                  0) {
                                                servicePayment = item
                                                        .channel?[index]
                                                        .fee
                                                        ?.actualFee ??
                                                    0;
                                              }
                                              if (item.channel?[index].fee
                                                      ?.feeType ==
                                                  'PERCENT') {
                                                percent = '%';
                                              }

                                              if ((item.channel?[index].fee
                                                          ?.additionalFee ??
                                                      0) >
                                                  0) {
                                                additionalService =
                                                    ' + ${(item.channel![index].fee!.additionalFee ?? 0)}';
                                              }
                                              return SizedBox(
                                                height: 48,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25, right: 25),
                                                  child: Column(children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          num feeFix = 0;
                                                          num actualFee = (item
                                                                  .channel?[
                                                                      index]
                                                                  .fee
                                                                  ?.actualFee ??
                                                              0);
                                                          num additionalFee = (item
                                                                  .channel?[
                                                                      index]
                                                                  .fee
                                                                  ?.additionalFee ??
                                                              0);
                                                          String feeType = (item
                                                                  .channel?[
                                                                      index]
                                                                  .fee
                                                                  ?.feeType ??
                                                              '');

                                                          if (feeType ==
                                                              'FLAT') {
                                                            feeFix = actualFee +
                                                                additionalFee;
                                                          } else if (feeType ==
                                                              'PERCENT') {
                                                            feeFix = (actualFee *
                                                                    totalBill /
                                                                    100) +
                                                                additionalFee;
                                                          }

                                                          choosePaymentMethod =
                                                              PaymentMethodArgs(
                                                                  paymentMethod:
                                                                      item.code,
                                                                  paymentChannel: item
                                                                      .channel?[
                                                                          index]
                                                                      .code,
                                                                  name:
                                                                      '${item.name}, ${item.channel?[index].name}',
                                                                  fee: feeFix);
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 40,
                                                            height: 40,
                                                            child: CachedNetworkImage(
                                                                imageUrl: item
                                                                        .channel?[
                                                                            index]
                                                                        .icon ??
                                                                    ''),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  item
                                                                          .channel?[
                                                                              index]
                                                                          .name ??
                                                                      '',
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13)),
                                                              Text(
                                                                'Biaya penanganan $servicePayment$percent$additionalService',
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        11),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    index ==
                                                            ((item.channel
                                                                        ?.length ??
                                                                    0) -
                                                                1)
                                                        ? const SizedBox()
                                                        : Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 0.5,
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            ],
                                                          )
                                                  ]),
                                                ),
                                              );
                                            }),
                                      ),
                                      isExpanded: item.isExpanded);
                                }).toList()),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                choosePaymentMethod != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Biaya penanganan',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.black),
                            ),
                            Text(
                              Currency.toRupiah(choosePaymentMethod?.fee),
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.black),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: CustomButtonStyle.styleDarkBlueButton(),
                        onPressed: () {
                          Navigator.pop(context, choosePaymentMethod);
                        },
                        child: Text(
                          'KONFIRMASI',
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
