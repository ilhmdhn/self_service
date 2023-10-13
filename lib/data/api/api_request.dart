import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/base_response.dart';
import 'package:self_service/data/model/fnb_category.dart';
import 'package:self_service/data/model/fnb_model.dart';
import 'package:self_service/data/model/member_model.dart';
import 'package:self_service/data/model/new_room_model.dart';
import 'package:self_service/data/model/pricing_model.dart';
import 'package:self_service/data/model/promo_model.dart';
import 'package:self_service/data/model/room_detail_model.dart';
import 'package:self_service/data/model/room_price_model.dart';
import 'package:self_service/data/model/voucher_model.dart';
import 'package:self_service/util/order_args.dart';
import '../shared_pref/preferences_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  Future<String> baseUrl() async {
    final url = await PreferencesData.getBaseUrl();
    return 'http://$url/';
  }

  Future<NewListRoomModel> getListRoom() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}room-list');
      final apiResponse = await http.get(url);
      return NewListRoomModel.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return NewListRoomModel(
          isLoading: false, state: false, message: err.toString());
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
      return FnBCategoryResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<FnBResultModel> getInventory(
      int page, String category, String search) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse(
          '${serverUrl}fnb-list?page=$page&category=$category&search=$search');
      final apiResponse = await http.get(url);
      return FnBResultModel.fromJson(json.decode(apiResponse.body));
    } catch (err) {
      return FnBResultModel(
          isLoading: false, state: false, message: err.toString());
    }
  }

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
          voucherData: []);
    }
  }

  Future<MemberResult> getMember(memberCode) async {
    try {
      String? key = dotenv.env['key'] ?? '';
      Uri url = Uri.parse(
          'https://ihp-membership.azurewebsites.net/member-info?member_code=$memberCode');
      final apiResponse = await http.get(url, headers: {'Authorization': key});
      final convertedResult = json.decode(apiResponse.body);
      return MemberResult.fromJson(convertedResult);
    } catch (err) {
      return MemberResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<RoomPriceResult> getRoomPrice(String category, int duration) async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse(
          '${serverUrl}room-price?room_category=$category&checkin_duration=$duration');
      final apiResponse = await http.get(url);
      final convertedResult = json.decode(apiResponse.body);
      return RoomPriceResult.fromJson(convertedResult);
    } catch (err) {
      return RoomPriceResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<ServiceTaxResult> getTaxService() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}service-tax');
      final apiResponse = await http.get(url);
      final convertedResult = json.decode(apiResponse.body);
      return ServiceTaxResult.fromJson(convertedResult);
    } catch (err) {
      return ServiceTaxResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<BaseResponse> postCheckinPayLater(CheckinArgs dataCheckin) async {
    try {
      List<Map<String, dynamic>> listFnb = [];

      if (dataCheckin.orderArgs!.fnb.fnbList.isNotEmpty) {
        for (var element in dataCheckin.orderArgs!.fnb.fnbList) {
          listFnb.add({
            'id_global':element.idGlobal,
            'id_local':element.idLocal,
            'item_name':element.itemName,
            'note':element.note,
            'qty':element.qty,
            'price':element.price,
          });
        }
      }

      // final bodyParams = {
      //   'member_name':dataCheckin.orderArgs?.memberCode,
      //   'memberCode':dataCheckin.orderArgs?.memberName,
      //   ''
      // };

      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}checkin-paylater');
      final apiResponse =
          await http.post(url, headers: {"Content-Type": "application/json"});
      final convertedResult = json.decode(apiResponse.body);
      return BaseResponse.fromJson(convertedResult);
    } catch (err) {
      return BaseResponse(
          isLoading: false, state: false, message: err.toString());
    }
  }
}
