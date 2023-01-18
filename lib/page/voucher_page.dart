import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/bloc/checkin_data_bloc.dart';
import 'package:self_service/bloc/promo_voucer_bloc.dart';
import 'package:self_service/data/model/checkin_model.dart';
import 'package:self_service/data/model/promo_model.dart';
import 'package:self_service/data/model/voucher_model.dart';

class VoucherPage extends StatelessWidget {
  VoucherPage({super.key});

  final PromoRoomCubit promoRoomCubit = PromoRoomCubit();
  final PromoFnBCubit promoFnBCubit = PromoFnBCubit();
  final VouchermembershipCubit vouchermembershipCubit =
      VouchermembershipCubit();
  final CheckinDataCubit checkinDataCubit = CheckinDataCubit();

  @override
  Widget build(BuildContext context) {
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
    checkinDataCubit.dataCheckin(checkinDataArgs);
    promoRoomCubit.getData();
    promoFnBCubit.getData();
    vouchermembershipCubit.getData(checkinDataArgs.checkinInfo.memberCode);
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
                  InkWell(
                    onTap: () {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Center(child: Text('Promo Room')),
                                  content: BlocBuilder<PromoRoomCubit,
                                      PromoDataResult>(
                                    bloc: promoRoomCubit,
                                    builder: (context, statePromoRoom) {
                                      if (statePromoRoom.isLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (statePromoRoom.state == false) {
                                        return Center(
                                          child: Text(statePromoRoom.message
                                              .toString()),
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
                                          itemCount: statePromoRoom
                                              .promo?.length
                                              .toInt(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.pop(
                                                    context,
                                                    statePromoRoom
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
                                                                .promo?[index]
                                                                .name
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
                              })
                          .then((value) => {
                                checkinDataArgs.promoInfo.promoRoom.promoName = value,
                                checkinDataCubit.dataCheckin(checkinDataArgs)
                              });
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          border: Border.all(color: Colors.black54, width: 0.3),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('Promo Room'),
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
                                              return Container(
                                                margin: const EdgeInsets.only(
                                                    top: 8),
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
                                              );
                                            }),
                                      );
                                    }));
                          });
                    },
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            border:
                                Border.all(color: Colors.black54, width: 0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text('Promo FnB')),
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
                                      bloc: vouchermembershipCubit,
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
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
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
                                                              8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(stateVoucher
                                                                  .voucherData?[
                                                                      index]
                                                                  .voucherName ??
                                                              "")
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }));
                                      }),
                                ));
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              border:
                                  Border.all(color: Colors.black54, width: 0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('Voucher Membership'))),
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
