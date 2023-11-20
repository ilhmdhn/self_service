import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/pricing_model.dart';
import 'package:self_service/data/model/promo_food_model.dart';
import 'package:self_service/data/model/promo_room_model.dart';
import 'package:self_service/data/model/room_price_model.dart';
import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';
import 'package:self_service/util/calculate_order.dart';
import 'package:self_service/util/order_args.dart';

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
      final response = await ApiService().voucher(memberCode);
      emit(response);
    }
  }
}

class PromoRoomCubit extends Cubit<PromoRoomResult> {
  PromoRoomCubit() : super(PromoRoomResult());

  void getData(String roomType) async {
    final response = await ApiService().promoRoom();
    List<PromoRoomData> listRoom = response.promo ?? [];
    // List<Item> filteredItems = items.where((item) => item.quantity > minQuantity).toList();
    List<PromoRoomData> isItemInCode = listRoom
        .where((item) => item.room == roomType || item.room == '[NONE]')
        .toList();
    response.promo = isItemInCode;
    emit(response);
  }
}

class PromoFoodCubit extends Cubit<PromoFoodResult> {
  PromoFoodCubit() : super(PromoFoodResult());

  void getData() async {
    final response = await ApiService().promoFood();
    emit(response);
  }
}

class PaymentMethodCubit extends Cubit<PaymentMethodArgs> {
  PaymentMethodCubit() : super(PaymentMethodArgs());

  void setData(PaymentMethodArgs data) {
    emit(data);
  }
}

class CheckinArgsCubit extends Cubit<CheckinArgs> {
  CheckinArgsCubit() : super(CheckinArgs());

  void setData(CheckinArgs checkinArgs) {
    emit(calculateOrder(checkinArgs));
  }
}
