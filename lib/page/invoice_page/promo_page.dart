import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:self_service/data/model/promo_food_model.dart';
import 'package:self_service/data/model/promo_room_model.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';
import 'package:self_service/page/style/button_style.dart';
import 'package:self_service/util/order_args.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});
  static const nameRoute = '/promo-page';

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  Widget build(BuildContext context) {
    CheckinArgs checkinArgs =
        ModalRoute.of(context)!.settings.arguments as CheckinArgs;
    final promoRoomCubit = PromoRoomCubit();
    final promoFoodCubit = PromoFoodCubit();

    promoRoomCubit.getData();
    promoFoodCubit.getData();

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
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(roomPromoState
                                              .promo?[index].promoRoom ??
                                          '')
                                    ],
                                  );
                                });
                          }),
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
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(foodPromoState
                                              .promo?[index].promoFood ??
                                          '')
                                    ],
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
                        fontSize: 16, fontWeight: FontWeight.w500),
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
