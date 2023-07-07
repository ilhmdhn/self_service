import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/api/api_test.dart';

class RoomDetailCubit extends Cubit<RoomDetailResult> {
  RoomDetailCubit() : super(RoomDetailResult());

  void setData(String roomCategory, String roomCode) async {
    final response = await ApiTest().roomDetail(roomCategory, roomCode);
    emit(response);
  }
}
