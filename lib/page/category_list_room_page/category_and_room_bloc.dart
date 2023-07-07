import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/room_list_model.dart';
import '../../data/model/room_category_model.dart';

class RoomCategoryCubit extends Cubit<RoomCategoryResult> {
  RoomCategoryCubit() : super(RoomCategoryResult());

  void getData() async {
    final response = await ApiTest().roomCategory();
    emit(response);
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
