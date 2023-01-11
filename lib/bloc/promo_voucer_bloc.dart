import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/promo_model.dart';
import 'package:self_service/data/model/voucher_model.dart';

class PromoRoomCubit extends Cubit<PromoDataResult> {
  PromoRoomCubit() : super(PromoDataResult());

  void getData() async {
    final response = await ApiService().getPromoRoom();
    emit(response);
  }
}

class PromoFnBCubit extends Cubit<PromoDataResult> {
  PromoFnBCubit() : super(PromoDataResult());

  void getData() async {
    final response = await ApiService().getPromoFnB();
    emit(response);
  }
}

class VouchermembershipCubit extends Cubit<VoucherDataResult> {
  VouchermembershipCubit() : super(VoucherDataResult());

  void getData(memberCode) async {
    final response = await ApiService().getVoucherMembership(memberCode);
    emit(response);
  }
}
