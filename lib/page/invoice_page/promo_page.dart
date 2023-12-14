import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/data/model/promo_food_model.dart';
import 'package:self_service/data/model/promo_room_model.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/page/style/color_style.dart';
import 'package:self_service/util/currency.dart';
import 'package:self_service/util/order_args.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});
  static const nameRoute = '/promo-page';

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  CheckinArgs checkinArgs = CheckinArgs();
  final promoRoomCubit = PromoRoomCubit();
  final promoFoodCubit = PromoFoodCubit();
  @override
  void initState() {
    promoRoomCubit.getData(checkinArgs.orderArgs?.roomCategory ?? '[NONE]');
    promoFoodCubit.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkinArgs = ModalRoute.of(context)!.settings.arguments as CheckinArgs;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, checkinArgs);
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Promo Room',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                      BlocBuilder<PromoRoomCubit, PromoRoomResult>(
                          bloc: promoRoomCubit,
                          builder: (context, roomPromoState) {
                            if (roomPromoState.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (roomPromoState.state != true) {
                              return Center(
                                child: Text(roomPromoState.message ??
                                    'Gagal mengambil data promo room'),
                              );
                            }

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: roomPromoState.promo?.length ?? 0,
                                itemBuilder: (context, index) {
                                  bool thisChoose = false;
                                  String promoValue = '';
                                  String promoTime =
                                      '${roomPromoState.promo?[index].timeStart} - ${roomPromoState.promo?[index].timeFinish}';
                                  if ((roomPromoState
                                              .promo?[index].diskonPersen ??
                                          0) >
                                      0) {
                                    promoValue =
                                        'Promo ${roomPromoState.promo?[index].diskonPersen}%';
                                  } else if ((roomPromoState
                                              .promo?[index].diskonRp ??
                                          0) >
                                      0) {
                                    promoValue =
                                        'Promo ${Currency.toRupiah((roomPromoState.promo?[index].diskonRp ?? 0))}%';
                                  }

                                  if (checkinArgs.promoRoom?.promoRoom !=
                                          null &&
                                      checkinArgs.promoRoom?.promoRoom ==
                                          roomPromoState
                                              .promo?[index].promoRoom) {
                                    thisChoose = true;
                                  }

                                  return Container(
                                    color: thisChoose == true
                                        ? Colors.amber
                                        : CustomColorStyle.lightBlue(),
                                    child: InkWell(
                                      onTap: () {
                                        if (thisChoose) {
                                          setState(() {
                                            checkinArgs.promoRoom = null;
                                          });
                                        } else {
                                          setState(() {
                                            checkinArgs.promoRoom =
                                                roomPromoState.promo?[index];
                                          });
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(roomPromoState.promo?[index]
                                                      .promoRoom ??
                                                  ''),
                                              Text(promoValue)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Masa berlaku promo'),
                                              Text(promoTime)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                      Text(
                        'Promo FnB',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      BlocBuilder<PromoFoodCubit, PromoFoodResult>(
                          bloc: promoFoodCubit,
                          builder: (context, foodPromoState) {
                            if (foodPromoState.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (foodPromoState.state != true) {
                              return Center(
                                child: Text(foodPromoState.message ??
                                    'Gagal mengambil data promo fnb'),
                              );
                            }

                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: foodPromoState.promo?.length ?? 0,
                                itemBuilder: (context, index) {
                                  bool thisChoose = false;
                                  String promoValue = '';
                                  String item = 'All FnB';
                                  bool promoState = true;
                                  PromoFoodData promoData =
                                      foodPromoState.promo![index];
                                  int roomCategory = 0;
                                  int voucherCategoryCondition = 0;
                                  String category =
                                      checkinArgs.orderArgs?.roomCategory ?? '';
                                  String promoRoomCategory =
                                      foodPromoState.promo?[index].jenisKamar ??
                                          '';
                                  String reason = '';

                                  if (category.contains('BAR')) {
                                    roomCategory = 1;
                                  } else if (category.contains('SMALL')) {
                                    roomCategory = 2;
                                  } else if (category.contains('MEDIUM')) {
                                    roomCategory = 3;
                                  } else if (category.contains('LARGE')) {
                                    roomCategory = 4;
                                  } else {
                                    roomCategory = 4;
                                  }

                                  if (promoRoomCategory.contains('BAR')) {
                                    voucherCategoryCondition = 1;
                                  } else if (promoRoomCategory
                                      .contains('SMALL')) {
                                    voucherCategoryCondition = 2;
                                  } else if (promoRoomCategory
                                      .contains('MEDIUM')) {
                                    voucherCategoryCondition = 3;
                                  } else if (promoRoomCategory
                                      .contains('LARGE')) {
                                    voucherCategoryCondition = 4;
                                  } else {
                                    voucherCategoryCondition = 4;
                                  }

                                  if (promoState &&
                                      (promoData.syaratKamar ?? 0) == 1 &&
                                      (roomCategory >
                                          voucherCategoryCondition)) {
                                    promoState = false;
                                    reason = 'Tipe Room Tidak Sesuai';
                                  }

                                  if (promoState &&
                                      (promoData.syaratDurasi ?? 0) == 1 &&
                                      (checkinArgs.orderArgs?.checkinDuration ??
                                              0) <
                                          (promoData.durasi ?? 0)) {
                                    promoState = false;
                                    reason =
                                        'Syarat durasi checkin tidak terpenuhi';
                                  }

                                  if (promoState &&
                                      (promoData.syaratHari ?? 0) == 1 &&
                                      (checkinArgs.roomPrice?.detail?[0].day ??
                                              0) !=
                                          (promoData.hari ?? 0)) {
                                    promoState = false;
                                    reason = 'Hari ini tidak berlaku';
                                  }

                                  if (promoState &&
                                      (checkinArgs.orderArgs?.checkinDuration ??
                                              0) <
                                          (promoData.syaratDurasi ?? 0)) {
                                    promoState = false;
                                    reason =
                                        'Syarat durasi checkin tidak terpenuhi';
                                  }

                                  int qtyFnb = 0;
                                  List<String> listFnb = [];
                                  checkinArgs.orderArgs?.fnb.fnbList
                                      .forEach((element) {
                                    qtyFnb = qtyFnb + (element.qty).toInt();
                                    listFnb.add(element.idGlobal ?? '');
                                  });

                                  if (promoState &&
                                      (promoData.syaratQuantity ?? 0) == 1 &&
                                      qtyFnb < (promoData.quantity ?? 0)) {
                                    promoState = false;
                                    reason = 'Jumlah fnb tidak terpenuhi';
                                  }

                                  if (promoState &&
                                      promoData.syaratInventory == 1) {
                                    promoState = false;
                                    reason = 'Jumlah fnb tidak terpenuhi';

                                    for (var element in listFnb) {
                                      if (element == promoData.inventory) {
                                        promoState = true;
                                        reason = '';
                                      }
                                    }
                                  }

                                  if ((foodPromoState
                                              .promo?[index].diskonPersen ??
                                          0) >
                                      0) {
                                    promoValue =
                                        'Promo ${foodPromoState.promo?[index].diskonPersen}%';
                                  } else if ((foodPromoState
                                              .promo?[index].diskonRp ??
                                          0) >
                                      0) {
                                    promoValue =
                                        'Promo ${Currency.toRupiah((foodPromoState.promo?[index].diskonRp ?? 0))}%';
                                  }

                                  if (checkinArgs.promoFood?.promoFood !=
                                          null &&
                                      checkinArgs.promoFood?.promoFood ==
                                          foodPromoState
                                              .promo?[index].promoFood) {
                                    thisChoose = true;
                                  }

                                  if (foodPromoState.promo?[index].inventory !=
                                      '') {
                                    item = (foodPromoState
                                            .promo?[index].inventory ??
                                        '');
                                  }

                                  return Container(
                                    color: thisChoose == true
                                        ? Colors.amber
                                        : CustomColorStyle.lightBlue(),
                                    child: InkWell(
                                      onTap: () {
                                        if (promoState == true) {
                                          if (promoState) {
                                            if (thisChoose) {
                                              setState(() {
                                                checkinArgs.promoFood = null;
                                              });
                                            } else {
                                              setState(() {
                                                checkinArgs.promoFood =
                                                    foodPromoState
                                                        .promo?[index];
                                              });
                                            }
                                          }
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(foodPromoState.promo?[index]
                                                      .promoFood ??
                                                  ''),
                                              Text(promoValue)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Item'),
                                              Text(item)
                                            ],
                                          ),
                                          promoState == false
                                              ? SizedBox(child: Text(reason))
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, checkinArgs);
                  },
                  style: CustomButtonStyle.buttonStyleDarkBlue(),
                  child: Text(
                    'KONFIRMASI',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
