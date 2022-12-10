import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/room_category.dart';

class ApiService {
  Future<RoomCategoryResult> getRoomCategory() async {
    Uri url = Uri.parse('http://192.168.1.248:3001/room-category');
    final apiResponse = await http.get(url);

    if (apiResponse.statusCode == 200) {
      return RoomCategoryResult.fromJson(json.decode(apiResponse.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
