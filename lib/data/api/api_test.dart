import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:self_service/data/model/room_list_model.dart';
import '../model/room_category_model.dart';

class ApiTest {
  Future<RoomCategoryResult> roomCategory() async {
    try {
      final result =
          await rootBundle.loadString('assets/data_test/category_room.json');
      final convertedResult = await json.decode(result);
      return RoomCategoryResult.fromJson(convertedResult);
    } catch (e) {
      return RoomCategoryResult(
          isLoading: false,
          state: false,
          message: e.toString(),
          category: List.empty());
    }
  }

  Future<RoomListResult> roomList(String category) async {
    try {
      final response =
          await rootBundle.loadString('assets/data_test/list_room.json');
      final convertedResult = await json.decode(response);
      final parseResult = RoomListResult.fromJson(convertedResult);
      final filtered = parseResult.room
          ?.where((result) => result.roomCategory == category)
          .toList();
      return RoomListResult(
          state: parseResult.state,
          isLoading: false,
          message: parseResult.message,
          room: filtered);
    } catch (e) {
      return RoomListResult(
          isLoading: false, message: e.toString(), room: List.empty());
    }
  }
}
