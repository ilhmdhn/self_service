import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:self_service/bloc/universal_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/payment_qris.dart';
import 'package:self_service/data/model/payment_va.dart';
import 'package:self_service/page/payment_page/payment_bloc.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/util/tools.dart';
import 'package:slide_countdown/slide_countdown.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});
  static const nameRoute = '/payment-page';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  CheckinArgs checkinData = CheckinArgs();
  @override
  Widget build(BuildContext context) {
    checkinData = ModalRoute.of(context)!.settings.arguments as CheckinArgs;
    PaymentQrisCubit paymentQrisCubit = PaymentQrisCubit();
    PaymentVaCubit paymentVaCubit = PaymentVaCubit();
    InputCubit expiredTimeCubit = InputCubit();

    String paymentMethod = checkinData.payment?.paymentMethod ?? '';
    String paymentChannel = checkinData.payment?.paymentChannel ?? '';
    num totalCheckin = (checkinData.roomPrice?.totalAll??0) + (checkinData.orderArgs?.fnb.totalAll??0);

    String memberName = checkinData.orderArgs?.memberName ?? '';
    String memberPhone = checkinData.orderArgs?.memberPhone ?? '';
    String memberEmail = checkinData.orderArgs?.memberEmail ?? '';

    if (memberPhone.startsWith('+')) {
      memberPhone = memberPhone.substring(1);
    }

    if (paymentMethod == 'va') {
      paymentVaCubit.getData(paymentMethod, paymentChannel, totalCheckin,
          memberName, memberPhone, memberEmail, checkinData);
    } else if (paymentMethod == 'qris') {
      paymentQrisCubit.getData(paymentMethod, paymentChannel, totalCheckin,
          memberName, memberPhone, memberEmail, checkinData);
    }

    return Scaffold(
      backgroundColor: CustomColorStyle.lightBlue(),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, checkinData);
          return true;
        },
        child: Container(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                            BlocBuilder<InputCubit, String>(
                              bloc: expiredTimeCubit,
                              builder: (context, expiredTimeState) {
                                return Text(
                                  expiredTimeState,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                );
                              },
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
                      )
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              paymentMethod == 'va'
                  ? SizedBox(
                      child: BlocBuilder<PaymentVaCubit, PaymentVaResult>(
                          bloc: paymentVaCubit,
                          builder: (context, paymmentVaState) {
                            if (paymmentVaState.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (paymmentVaState.state != true ||
                                paymmentVaState.data == null) {
                              return Center(
                                child: Text(paymmentVaState.message ?? 'Error'),
                              );
                            }

                            VirtualAccountData dataVa = paymmentVaState.data!;
                            expiredTimeCubit.getData(dataVa.expiredTime);
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: CustomColorStyle.blueQrisBg(),
                                      borderRadius: BorderRadius.circular(26)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/icon/payment/virtualaccount.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                const Icon(
                                                  Icons.credit_card,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            Text(
                                              '${dataVa.via} ${dataVa.channel}',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          19)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Text(
                                                  dataVa.paymentNo ?? '',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black87,
                                                      letterSpacing: 2),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Total',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                  Text(
                                                      Currency.toRupiah(
                                                          dataVa.total ?? 0),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
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
                                                'Instruksi Pembayaran',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "1. Buka aplikasi perbankan Anda.",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '2. Pilih opsi "Pembayaran Virtual Account.',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '3. Masukkan nomor Virtual Account diatas.',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '4. Pastikan nominal pembayaran sesuai dengan nominal diatas.',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      '5. Jika sudah tekan tombol selesai dibawah.',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              CustomColorStyle()
                                                                  .hexToColor(
                                                                      '#24accc'),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          225.0)),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              checkinData);
                                                        },
                                                        child: Text(
                                                          'Ubah Pembayaran',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                        style: CustomButtonStyle
                                                            .buttonStyleDarkBlue(),
                                                        onPressed: () async {
                                                          final checkinResponse = await ApiService().checkin(checkinData, dataVa.transactionId.toString());
                                                        },
                                                        child: Text(
                                                          'Selesai',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
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
                                ),
                              ),
                            );
                          }),
                    )
                  : paymentMethod == 'qris'
                      ? BlocBuilder<PaymentQrisCubit, QrisPaymentResult>(
                          bloc: paymentQrisCubit,
                          builder: (context, paymentQrisState) {
                            if (paymentQrisState.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (paymentQrisState.state != true ||
                                paymentQrisState.data == null) {
                              return Center(
                                child:
                                    Text(paymentQrisState.message ?? 'error'),
                              );
                            }
                            QrisData? dataQris = paymentQrisState.data;
                            expiredTimeCubit
                                .getData(dataQris?.expiredTime ?? '');

                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: CustomColorStyle.blueQrisBg(),
                                  borderRadius: BorderRadius.circular(26)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
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
                                          dataQris?.paymentName ?? '',
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Session ID: ${dataQris?.sessionId ?? ''}',
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
                                              data: dataQris?.qrString ?? '',
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
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                  Currency.toRupiah(
                                                      dataQris?.total ?? 0),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600)),
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
                                                fontSize: 14,
                                                color: Colors.black),
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
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          CustomColorStyle()
                                                              .hexToColor(
                                                                  '#24accc'),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          225.0)),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, checkinData);
                                                    },
                                                    child: Text(
                                                      'Ubah Pembayaran',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: ElevatedButton(
                                                    style: CustomButtonStyle
                                                        .buttonStyleDarkBlue(),
                                                    onPressed: () async {
                                                      final response =
                                                          await ApiService().checkin(
                                                              checkinData,
                                                              (dataQris?.referenceId ??
                                                                      0)
                                                                  .toString());
                                                      if (response.state !=
                                                          true) {
                                                        showToastWarning(
                                                            response.message ??
                                                                '');
                                                      } else {
                                                        showToastWarning(
                                                            'Berhasil');
                                                      }
                                                    },
                                                    child: Text(
                                                      'Selesai',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                            );
                          })
                      : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
