import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/model/room_list_model.dart';
import 'package:self_service/util/tools.dart';
import '../model/room_category_model.dart';

class ApiTest {
  Future<RoomCategoryResult> roomCategory() async {
    try {
      final result =
          await rootBundle.loadString('assets/data_test/category_room.json');
      final convertedResult = await json.decode(result);
      await delay(const Duration(seconds: 1));
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
      await delay(const Duration(seconds: 1));
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

  Future<RoomDetailResult> roomDetail(String category, String roomCode) async {
    try {
      final response = await rootBundle.loadString('assets/data_test/detail_room.json');
      final convertedResult = await json.decode(response);
      await delay(const Duration(seconds: 1));
      final parseResult = RoomDetailResult.fromJson(convertedResult);
      return parseResult;
    } catch (e) {
      return RoomDetailResult(
          isLoading: false, state: false, message: e.toString());
    }
  }
}
