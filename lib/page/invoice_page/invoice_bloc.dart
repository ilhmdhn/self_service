import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/slip_checkin_model.dart';
import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class SlipCheckinCubit extends Cubit<SlipCheckinResult> {
  SlipCheckinCubit() : super(SlipCheckinResult());

  void setData(String roomType, int duration) async {
    final isTestMode = await PreferencesData.getTestMode();
    if (isTestMode) {
      final response = await ApiTest().slipCheckin();
      emit(response);
    } else {
      final response = await ApiTest().slipCheckin();
      emit(response);
    }
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
