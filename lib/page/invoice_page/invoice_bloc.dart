import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/pricing_model.dart';
import 'package:self_service/data/model/room_price_model.dart';
import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class SlipCheckinCubit extends Cubit<RoomPriceResult> {
  SlipCheckinCubit() : super(RoomPriceResult());

  void setData(String roomType, int duration) async {
    final response = await ApiService().getRoomPrice(roomType, duration);
    emit(response);
  }
}

class TaxServiceCubit extends Cubit<ServiceTaxResult> {
  TaxServiceCubit() : super(ServiceTaxResult());

  void getData() async {
    final response = await ApiService().getTaxService();
    emit(response);
  }
}

class VoucherCubit extends Cubit<VoucherDataResult> {
  VoucherCubit() : super(VoucherDataResult());

  void setData(String memberCode) async {
    final isTestMode = await PreferencesData.getTestMode();
    if (isTestMode) {
      final response = await ApiTest().voucher();
      emit(response);
    } else {
      final response = await ApiTest().voucher();
      emit(response);
    }
  }
}
