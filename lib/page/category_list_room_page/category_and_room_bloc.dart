import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/new_room_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';
import 'package:self_service/data/api/api_request.dart';

class NewListRoomCubit extends Cubit<NewListRoomModel> {
  NewListRoomCubit() : super(NewListRoomModel());

  void getData() async {
    final response = await ApiTest().newListRoom();
    emit(response);
  }
}

class ListRoomCubit extends Cubit<List<RoomList>> {
  ListRoomCubit() : super([]);

  void setData(List<RoomList> list) {
    emit(list);
  }
}

class ChooseCategoryCubit extends Cubit<RoomCategory> {
  ChooseCategoryCubit() : super(RoomCategory());

  void setData(RoomCategory category) {
    emit(category);
  }
}