import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final checkinDataArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinData;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Promo Room'),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<PromoRoomCubit, PromoDataResult>(
                      bloc: promoRoomCubit,
                      builder: (context, statePromoRoom) {
                        if (statePromoRoom.isLoading == true) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (statePromoRoom.state == false) {
                          return Center(
                            child: Text(statePromoRoom.message.toString()),
                          );
                        }

                        return DropdownSearch<PromoData>(
                          items: statePromoRoom.promo as List<PromoData>,
                          itemAsString: (PromoData p) => p.name.toString(),
                          onChanged: (PromoData? data) => print(data),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: "Promo Room"),
                          ),
                        );
                      }),
                  BlocBuilder<PromoFnBCubit, PromoDataResult>(
                      bloc: promoFnBCubit,
                      builder: (context, statePromoFnB) {
                        if (statePromoFnB.isLoading == true) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (statePromoFnB.state == false) {
                          return Center(
                            child: Text(statePromoFnB.message.toString()),
                          );
                        }

                        return DropdownSearch<PromoData>(
                          items: statePromoFnB.promo as List<PromoData>,
                          itemAsString: (PromoData p) => p.name.toString(),
                          onChanged: (PromoData? data) => print(data),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: "Promo FnB"),
                          ),
                        );
                      }),
                  BlocBuilder<VouchermembershipCubit, VoucherDataResult>(
                      bloc: vouchermembershipCubit,
                      builder: (context, stateVoucher) {
                        if (stateVoucher.isLoading == true) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (stateVoucher.state == false) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DropdownSearch<VoucherData>(
                          items: stateVoucher.voucherData as List<VoucherData>,
                          itemAsString: (VoucherData v) =>
                              v.voucherName.toString(),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration:
                                InputDecoration(labelText: "Voucher Member"),
                          ),
                        );
                      })
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
