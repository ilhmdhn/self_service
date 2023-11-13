import 'package:flutter/material.dart';
import 'package:self_service/bloc/promo_voucer_bloc.dart';
import 'package:self_service/page/invoice_page/invoice_bloc.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final promoRoomCubit = PromoRoomCubit();
    final promoFoodCubit = PromoFoodCubit();

    return const Scaffold(
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
