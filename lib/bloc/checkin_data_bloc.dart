import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/checkin_model.dart';

class CheckinDataCubit extends Cubit<CheckinData> {
  CheckinDataCubit() : super(CheckinData(checkinInfo: CheckinInfo(), fnbInfo: FnBInfo(), promoInfo: PromoInfo()));

  void dataCheckin(data) async {
    emit(data);
  }
}
