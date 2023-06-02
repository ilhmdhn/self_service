import 'dart:convert';
import 'package:flutter/services.dart';
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
}