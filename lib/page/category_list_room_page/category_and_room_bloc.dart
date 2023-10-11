import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/model/new_room_model.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class NewListRoomCubit extends Cubit<NewListRoomModel> {
  NewListRoomCubit() : super(NewListRoomModel());

  void getData() async {
    final isTestMode = await PreferencesData.getTestMode();
    NewListRoomModel response;
    if (isTestMode) {
      response = await ApiTest().newListRoom();
    } else {
      response = await ApiService().getListRoom();
    }
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
