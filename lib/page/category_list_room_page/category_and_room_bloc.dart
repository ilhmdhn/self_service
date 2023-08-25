import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/room_list_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';
import '../../data/model/room_category_model.dart';
import 'package:self_service/data/api/api_request.dart';

class RoomCategoryCubit extends Cubit<RoomCategoryResult> {
  RoomCategoryCubit() : super(RoomCategoryResult());

  void getData() async {
    final isTestMode = await PreferencesData.getTestMode();
    if (isTestMode) {
      final response = await ApiTest().roomCategory();
      emit(response);
    } else {
      final response = await ApiService().getRoomCategory();
      emit(response);
    }
  }
}

class ChooseCategoryRoom extends Cubit<RoomCategory> {
  ChooseCategoryRoom() : super(RoomCategory());

  void setData(category) {
    emit(category);
  }
}

class RoomListCubit extends Cubit<RoomListResult> {
  RoomListCubit() : super(RoomListResult());

  void setDate(String category) async {
    final response = await ApiTest().roomList(category);
    emit(response);
  }
}
