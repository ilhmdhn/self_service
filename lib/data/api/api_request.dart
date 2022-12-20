import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/fnb_category_model.dart';
import 'package:self_service/data/model/room_category_model.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/model/room_list_model.dart';

class ApiService {
  Future<RoomCategoryResult> getRoomCategory() async {
    try {
      Uri url = Uri.parse('http://192.168.1.248:3001/room-category');
      final apiResponse = await http.get(url);
      return RoomCategoryResult.fromJson(json.decode(apiResponse.body));
    } catch (e) {
      return RoomCategoryResult(
          state: false, message: e.toString(), category: List.empty());
    }
  }

  Future<RoomListResult> getRoomList(String roomCategory) async {
    try {
      Uri url =
          Uri.parse('http://192.168.1.248:3001/room?category=$roomCategory');
      final apiResponse = await http.get(url);
      return RoomListResult.fromJson(json.decode(apiResponse.body));
    } catch (e) {
      return RoomListResult(state: false, message: e.toString(), room: []);
    }
  }

  Future<RoomDetailResult> getRoomDetail(roomCode) async {
    try {
      Uri url = Uri.parse(
          'http://192.168.1.248:3001/room-detail?room_code=$roomCode');
      final apiResponse = await http.get(url);
      return RoomDetailResult.fromJson(json.decode(apiResponse.body));
    } catch (e) {
      return RoomDetailResult(state: false, message: e.toString());
    }
  }

  Future<FnBCategoryResult> getFnBCategory() async {
    try {
      Uri url = Uri.parse('http://192.168.1.248:3001/fnb-category');
      final apiResponse = await http.get(url);
      return FnBCategoryResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return FnBCategoryResult(state: false, message: err.toString());
    }
  }
}
