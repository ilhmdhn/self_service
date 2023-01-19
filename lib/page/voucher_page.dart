import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/counter_bloc.dart';
import 'package:self_service/bloc/promo_voucer_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/promo_model.dart';
import 'package:self_service/data/model/voucher_model.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class VoucherPage extends StatelessWidget {
  VoucherPage({super.key});
    static const nameRoute = '/voucher';

  final PromoRoomCubit promoRoomCubit = PromoRoomCubit();
  final PromoFnBCubit promoFnBCubit = PromoFnBCubit();
  final VouchermembershipCubit voucherMembershipCubit =
      VouchermembershipCubit();
  final DynamicCubit chosenPromoRoomCubit = DynamicCubit();
  final DynamicCubit chosenPromoFnBCubit = DynamicCubit();
  final DynamicCubit chosenVoucherCubit = DynamicCubit();

  @override
  Widget build(BuildContext context) {
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    chosenPromoRoomCubit.getData(checkinDataArgs.promoInfo.promoRoom);
    chosenPromoFnBCubit.getData(checkinDataArgs.promoInfo.promoFnB);
    chosenVoucherCubit.getData(checkinDataArgs.voucherInfo.voucherCode);
    promoRoomCubit.getData();
    promoFnBCubit.getData();
    voucherMembershipCubit.getData(checkinDataArgs.checkinInfo.memberCode);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text('Voucher')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<DynamicCubit, dynamic>(
                    bloc: chosenPromoRoomCubit,
                    builder: (context, state) {
                      if (state != false) {
                        checkinDataArgs.promoInfo.promoRoom = state;
                      } else {
                        checkinDataArgs.promoInfo.promoRoom = false;
                      }
                      return Container(
                          child: state != false
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black54, width: 0.3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(state),
                                        IconButton(
                                            onPressed: () {
                                              chosenPromoRoomCubit
                                                  .getData(false);
                                            },
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox());
                    },
                  ),
                  BlocBuilder<DynamicCubit, dynamic>(
                      bloc: chosenPromoFnBCubit,
                      builder: (context, stateChosenFnBPromo) {
                        checkinDataArgs.promoInfo.promoFnB =
                            stateChosenFnBPromo;
                        return Container(
                          child: stateChosenFnBPromo != false
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black54, width: 0.3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(stateChosenFnBPromo),
                                        IconButton(
                                            onPressed: () {
                                              chosenPromoFnBCubit
                                                  .getData(false);
                                            },
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ))
                              : const SizedBox(),
                        );
                      }),
                  BlocBuilder<DynamicCubit, dynamic>(
                      bloc: chosenVoucherCubit,
                      builder: (context, stateVoucher) {
                        checkinDataArgs.voucherInfo.voucherCode = stateVoucher;
                        return Container(
                          child: stateVoucher != false
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black54, width: 0.3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Voucher Dipilih: $stateVoucher'),
                                        IconButton(
                                            onPressed: () {
                                              chosenVoucherCubit.getData(false);
                                            },
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ))
                              : const SizedBox(),
                        );
                      }),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Promo Room')),
                              content:
                                  BlocBuilder<PromoRoomCubit, PromoDataResult>(
                                bloc: promoRoomCubit,
                                builder: (context, statePromoRoom) {
                                  if (statePromoRoom.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (statePromoRoom.state == false) {
                                    return Center(
                                      child: Text(
                                          statePromoRoom.message.toString()),
                                    );
                                  }
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView.builder(
                                      itemCount:
                                          statePromoRoom.promo?.length.toInt(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pop(
                                                context,
                                                statePromoRoom
                                                    .promo?[index].name);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black54,
                                                  width: 0.3),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    statePromoRoom
                                                            .promo?[index].name
                                                            .toString() ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                          'Diskon Persen Room ${statePromoRoom.promo?[index].discountPercent}%'),
                                                      Text(
                                                          'Diskon Rupiah Room Rp.${statePromoRoom.promo?[index].discountIdr}')
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          }).then((value) => {
                            if (value != null)
                              {chosenPromoRoomCubit.getData(value)}
                          });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54, width: 0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                        child: Text('Promo Room'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Center(child: Text('Promo FnB')),
                                content: BlocBuilder<PromoFnBCubit,
                                        PromoDataResult>(
                                    bloc: promoFnBCubit,
                                    builder: (context, statePromoFnB) {
                                      if (statePromoFnB.isLoading) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (statePromoFnB.state == false) {
                                        return Center(
                                          child: Text(
                                              statePromoFnB.message.toString()),
                                        );
                                      }
                                      return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: ListView.builder(
                                            itemCount:
                                                statePromoFnB.promo?.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context,
                                                      statePromoFnB
                                                          .promo?[index].name);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black54,
                                                        width: 0.3),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(statePromoFnB
                                                                .promo?[index]
                                                                .name
                                                                .toString() ??
                                                            ''),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Text(
                                                                'Diskon Persen: ${statePromoFnB.promo?[index].discountPercent}%'),
                                                            Text(
                                                                'Diskon Rupiah: Rp.${statePromoFnB.promo?[index].discountIdr}'),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      );
                                    }));
                          }).then((value) => {
                            if (value != null)
                              {chosenPromoFnBCubit.getData(value)}
                          });
                    },
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54, width: 0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Text(
                              'Promo FnB',
                              textAlign: TextAlign.start,
                            ))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Center(
                                      child: Text('Voucher Member')),
                                  content: BlocBuilder<VouchermembershipCubit,
                                          VoucherDataResult>(
                                      bloc: voucherMembershipCubit,
                                      builder: (context, stateVoucher) {
                                        if (stateVoucher.isLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (stateVoucher.state == false) {
                                          return Center(
                                            child: Text(
                                                stateVoucher.message ?? ""),
                                          );
                                        }
                                        return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: ListView.builder(
                                                itemCount: stateVoucher
                                                    .voucherData?.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.pop(
                                                          context,
                                                          stateVoucher
                                                              .voucherData?[
                                                                  index]
                                                              .voucherCode);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.black54,
                                                            width: 0.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            SizedBox(
                                                              height: 75,
                                                              width: 133,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      'https://adm.happypuppy.id/${stateVoucher.voucherData?[index].image}',
                                                                  progressIndicatorBuilder:
                                                                      (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          Center(
                                                                    child: CircularProgressIndicator(
                                                                        value: downloadProgress
                                                                            .progress),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Center(
                                                                          child:
                                                                              Icon(Icons.error)),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                                child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(stateVoucher
                                                                        .voucherData?[
                                                                            index]
                                                                        .voucherName ??
                                                                    ""),
                                                                const SizedBox(
                                                                  height: 36,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(stateVoucher
                                                                            .voucherData?[index]
                                                                            .voucherCode
                                                                            .toString() ??
                                                                        ''),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (BuildContext context) =>
                                                                                AlertDialog(title: const Center(child: Text('Deskripsi Voucher')), content: HtmlWidget(stateVoucher.voucherData?[index].description.toString() ?? '')));
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'S&K',
                                                                        textAlign:
                                                                            TextAlign.end,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }));
                                      }),
                                )).then((value) => {
                              if (value != null)
                                {chosenVoucherCubit.getData(value)}
                            });
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black54, width: 0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 12),
                            child: Text('Voucher Membership'),
                          ))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll<Color>(Colors.red),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/splash', (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(fontSize: 18),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.lime.shade800),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Kembali',
                      style: TextStyle(fontSize: 18),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Colors.green)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/review-bill'
                          // ,arguments: checkinDataArgs
                          );
                    },
                    child: const Text(
                      'Lanjut',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
