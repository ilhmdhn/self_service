import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/api/api_test.dart';
import 'package:self_service/data/shared_pref/preferences_data.dart';

class RoomDetailCubit extends Cubit<RoomDetailResult> {
  RoomDetailCubit() : super(RoomDetailResult());

  void setData(String roomCategory, String roomCode) async {
    final isTestMode = await PreferencesData.getTestMode();
    RoomDetailResult response;
    if (isTestMode) {
      response = await ApiTest().roomDetail(roomCategory, roomCode);
    } else {
      response = await ApiService().getRoomDetail(roomCode);
    }
    emit(response);
  }
}
