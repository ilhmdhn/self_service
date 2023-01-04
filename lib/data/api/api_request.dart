import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/fnb_category_model.dart';
import 'package:self_service/data/model/inventory_model.dart';
import 'package:self_service/data/model/room_category_model.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/model/room_list_model.dart';
import '../shared_pref/preferences_data.dart';

class ApiService {
  Future<String> baseUrl() async {
    final url = await PreferencesData.getBaseUrl();
    return 'http://$url:3099/';
  }

  Future<RoomCategoryResult> getRoomCategory() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}room-category');
      final apiResponse = await http.get(url);
      return RoomCategoryResult.fromJson(json.decode(apiResponse.body));
    } catch (e) {
      return RoomCategoryResult(
          isLoading: false,
          state: false,
          message: e.toString(),
          category: List.empty());
    }
  }

  Future<RoomListResult> getRoomList(String roomCategory) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}room?category=$roomCategory');
      final apiResponse = await http.get(url);
      return RoomListResult.fromJson(json.decode(apiResponse.body));
    } catch (e) {
      return RoomListResult(
          isLoading: false, state: false, message: e.toString(), room: []);
    }
  }

  Future<RoomDetailResult> getRoomDetail(roomCode) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}room-detail?room_code=$roomCode');
      final apiResponse = await http.get(url);
      return RoomDetailResult.fromJson(json.decode(apiResponse.body));
    } catch (e) {
      return RoomDetailResult(
          isLoading: false, state: false, message: e.toString());
    }
  }

  Future<FnBCategoryResult> getFnBCategory() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}fnb-category');
      final apiResponse = await http.get(url);
      return FnBCategoryResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return FnBCategoryResult(state: false, message: err.toString());
    }
  }

  Future<InventoryResult> getInventory(
      int page, int size, String category, String search) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse(
          '${serverUrl}fnb?page=$page&size=$size&category=$category&search=$search');
      final apiResponse = await http.get(url);
      return InventoryResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return InventoryResult(state: false, message: err.toString());
    }
  }
}
