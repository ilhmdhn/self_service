import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/member_model.dart';
import 'package:self_service/data/model/promo_model.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/model/voucher_model.dart';
import '../shared_pref/preferences_data.dart';

class ApiService {
  Future<String> baseUrl() async {
    final url = await PreferencesData.getBaseUrl();
    return 'http://$url:3099/';
  }

  // Future<RoomCategoryResult> getRoomCategory() async {
  //   try {
  //     final serverUrl = await baseUrl();
  //     Uri url = Uri.parse('${serverUrl}room-category');
  //     final apiResponse = await http.get(url);
  //     return RoomCategoryResult.fromJson(json.decode(apiResponse.body));
  //   } catch (e) {
  //     return RoomCategoryResult(
  //         isLoading: false,
  //         state: false,
  //         message: e.toString(),
  //         category: List.empty());
  //   }
  // }

  // Future<RoomListResult> getRoomList(String roomCategory) async {
  //   try {
  //     final serverUrl = await baseUrl();
  //     Uri url = Uri.parse('${serverUrl}room?category=$roomCategory');
  //     final apiResponse = await http.get(url);
  //     return RoomListResult.fromJson(json.decode(apiResponse.body));
  //   } catch (e) {
  //     return RoomListResult(
  //         isLoading: false, state: false, message: e.toString(), room: []);
  //   }
  // }

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
/*
  Future<FnBCategoryResult> getFnBCategory() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}fnb-category');
      final apiResponse = await http.get(url);
      return FnBCategoryResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return FnBCategoryResult(
          isLoading: false, state: false, message: err.toString());
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
      return InventoryResult(
          isLoading: false, state: false, message: err.toString());
    }
  }
*/
  Future<MemberResult> getMember(String memberCode) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}member?member_code=$memberCode');
      final apiResponse = await http.get(url);
      return MemberResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return MemberResult(
          isLoading: false, state: false, data: null, message: err.toString());
    }
  }

/*
  Future<InventorySingleResult> getFnBSingle(String inventoryCode) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}fnb-id?kode_inventory=$inventoryCode');
      final apiResponse = await http.get(url);
      return InventorySingleResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return InventorySingleResult(
          isLoading: false,
          state: false,
          inventory: null,
          message: err.toString());
    }
  }
*/
  Future<PromoDataResult> getPromoRoom() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}promo/room');
      final apiResponse = await http.get(url);
      return PromoDataResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return PromoDataResult(
          isLoading: false, state: false, message: err.toString(), promo: []);
    }
  }

  Future<PromoDataResult> getPromoFnB() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}promo/fnb');
      final apiResponse = await http.get(url);
      return PromoDataResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return PromoDataResult(
          isLoading: false, state: false, message: err.toString(), promo: []);
    }
  }

  Future<VoucherDataResult> getVoucherMembership(memberCode) async {
    try {
      final serverUrl = await baseUrl();
      Uri url =
          Uri.parse('${serverUrl}voucher-membership?kode_member=$memberCode');
      final apiResponse = await http.get(url);
      return VoucherDataResult.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return VoucherDataResult(
        isLoading: false,
        state: false,
        message: err.toString(),
        voucherData: []
      );
    }
  }
}
