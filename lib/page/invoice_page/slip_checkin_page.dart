import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/data/model/room_price_model.dart';
import 'package:self_service/page/fnb_page/fnb_offering_page.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';
import 'package:self_service/page/splash_page/splash_screen.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';
import 'package:self_service/util/tools.dart';

class SlipCheckinPage extends StatefulWidget {
  const SlipCheckinPage({super.key});
  static const nameRoute = '/slip-checkin-page';
  @override
  State<SlipCheckinPage> createState() => _SlipCheckinPageState();
}

class _SlipCheckinPageState extends State<SlipCheckinPage> {
  bool agreement = false;

  final SlipCheckinCubit slipCheckinCubit = SlipCheckinCubit();
  OrderArgs orderArgs = OrderArgs();
  CheckinArgs checkinArgs = CheckinArgs();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orderArgs = ModalRoute.of(context)!.settings.arguments as OrderArgs;
    slipCheckinCubit.setData(orderArgs.roomCategory, orderArgs.checkinDuration);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, orderArgs);
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<SlipCheckinCubit, RoomPriceResult>(
            bloc: slipCheckinCubit,
            builder: (context, roomPriceState) {
              if (roomPriceState.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (roomPriceState.state == false) {
                return Center(
                  child: Text(roomPriceState.message.toString()),
                );
              }
              return Container(
                decoration: BoxDecoration(color: CustomColorStyle.lightBlue()),
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
                                                  Navigator.of(context)
                                                      .pop(orderArgs);
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Slip Check In',
                              style: GoogleFonts.poppins(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // children: [
                            // Expanded(
                            //   flex: 2,
                            //   child: Text(
                            //     'Kode Reservasi',
                            //     style: GoogleFonts.poppins(fontSize: 12),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 10),
                            //   child: Text(
                            //     ':',
                            //     style: GoogleFonts.poppins(fontSize: 14),
                            //   ),
                            // ),
                            //   Expanded(
                            //       flex: 4,
                            //       child: Text(
                            //         'RSV-12312312345678',
                            //         style: GoogleFonts.poppins(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w600),
                            //       ))
                            // ],
                            // ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            orderArgs.memberCode != orderArgs.memberName
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Kode Member',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              ':',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 4,
                                              child: Text(
                                                orderArgs.memberCode,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Nama Member',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      orderArgs.memberName,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
/*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Tanggal Reservasi',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      '1 September 2023',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Jam Reservasi',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      '15:00',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Tipe Room',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      orderArgs.roomCategory,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Durasi Checkin',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${orderArgs.checkinDuration.toString()} JAM',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Harga Room',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      Currency.toRupiah(
                                          roomPriceState.data?.roomPrice ?? 0),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            /*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Promo',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      '100.000',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Total Room',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      '400.000',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Service',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      Currency.toRupiah(
                                          roomPriceState.data?.serviceRoom ??
                                              0),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Pajak',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      Currency.toRupiah(
                                          roomPriceState.data?.taxRoom ?? 0),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
/*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Uang Muka',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      '100.000',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Jumlah',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    ':',
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      Currency.toRupiah(
                                          roomPriceState.data?.priceTotal ?? 0),
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                          child: Text('PERNYATAAN')),
                                      content: HtmlWidget('''
                                  <p align="justify">Saya dan rekan tidak akan membawa masuk dan atau mengkonsumsi makanan/ minuman yang bukan berasal
                                      dari outlet
                                      <strong>HAPPY PUPPY</strong> ini, Apabila terbukti kemudian, saya bersedia dikenakan denda sesuai dengan
                                      daftar denda yang berlaku.
                                  </p>
                                  <p>(${orderArgs.memberName})</p>
                                  <p>${orderArgs.memberCode}</p>
                                  '''),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Selesai')),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'SYARAT DAN KETENTUAN',
                                style: GoogleFonts.poppins(
                                    color: CustomColorStyle.darkRed(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Switch(
                                    value: agreement,
                                    inactiveThumbImage: const AssetImage(
                                        'assets/icon/togle_switch_off.png'),
                                    activeThumbImage: const AssetImage(
                                        'assets/icon/togle_switch_on.png'),
                                    onChanged: (state) {
                                      setState(() {
                                        agreement = !agreement;
                                      });
                                    }),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: Text(
                                  'Saya telah membaca dan menyetujui persyaratan dan kebijakan dari pihak manejemen Happy Puppy',
                                  style: GoogleFonts.poppins(fontSize: 10),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                checkinArgs = CheckinArgs(
                                    orderArgs: orderArgs,
                                    roomPrice: roomPriceState.data);
                                agreement == true
                                    ? Navigator.pushNamed(context,
                                            FnBOrderOfferingPage.nameRoute,
                                            arguments: checkinArgs)
                                        .then((argumenKembali) {
                                        checkinArgs =
                                            argumenKembali as CheckinArgs;
                                        orderArgs = checkinArgs.orderArgs??OrderArgs();
                                      })
                                    : {
                                        showToastWarning(
                                            "Setujui syarat dan ketentuan")
                                      };
                              },
                              style: agreement == true
                                  ? CustomButtonStyle.buttonStyleDarkBlue()
                                  : CustomButtonStyle
                                      .buttonStyleDarkBlueDisable(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Text(
                                  "LANJUT",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )),
                          const SizedBox(
                            height: 31,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
