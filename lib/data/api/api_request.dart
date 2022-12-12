import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/room_category_model.dart';

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

  
}