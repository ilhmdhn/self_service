import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:self_service/data/model/base_response.dart';
import 'package:self_service/data/model/fnb_category.dart';
import 'package:self_service/data/model/fnb_model.dart';
import 'package:self_service/data/model/list_payment.dart';
import 'package:self_service/data/model/member_model.dart';
import 'package:self_service/data/model/new_room_model.dart';
import 'package:self_service/data/model/payment_qris.dart';
import 'package:self_service/data/model/payment_va.dart';
import 'package:self_service/data/model/pricing_model.dart';
import 'package:self_service/data/model/promo_food_model.dart';
import 'package:self_service/data/model/promo_model.dart';
import 'package:self_service/data/model/promo_room_model.dart';
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

  Future<ListPaymentResult> listPaymentMethod() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}payment-list');
      final apiResponse = await http.get(url);
      final convertedResult = json.decode(apiResponse.body);
      return ListPaymentResult.fromJson(convertedResult);
    } catch (err) {
      return ListPaymentResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<QrisPaymentResult> getQrisPayment(
      String paymentMethod,
      String paymentChannel,
      num amount,
      String customer,
      String phone,
      String email,
      CheckinArgs checkinData) async {
    try {
      final dataCheckin = GenerateJsonParams().convert(checkinData);
      final dataJson = jsonEncode(dataCheckin);
      final Map<String, dynamic> bodyParams = {
        'payment_method': paymentMethod,
        'payment_channel': paymentChannel,
        'amount': amount.toString(),
        'customer': customer,
        'phone': phone,
        'email': email,
        'data_checkin': dataJson
      };
      final serverUrl = await baseUrl();
      final url = Uri.parse('${serverUrl}generate-payment');
      final apiResponse = await http.post(url, body: bodyParams);
      final convertedResult = json.decode(apiResponse.body);
      return QrisPaymentResult.fromJson(convertedResult);
    } catch (err) {
      return QrisPaymentResult(
        isLoading: false,
        state: false,
        message: err.toString(),
      );
    }
  }

  Future<PaymentVaResult> getVaPayment(
      String paymentMethod,
      String paymentChannel,
      num amount,
      String customer,
      String phone,
      String email,
      CheckinArgs checkinData) async {
    try {
      final dataCheckin = GenerateJsonParams().convert(checkinData);
      final dataJson = jsonEncode(dataCheckin);

      Map<String, dynamic> bodyParams = {
        'payment_method': paymentMethod,
        'payment_channel': paymentChannel,
        'amount': amount.toString(),
        'customer': customer,
        'phone': phone,
        'email': email,
        'data_checkin': dataJson
      };

      final serverUrl = await baseUrl();
      final url = Uri.parse('${serverUrl}generate-payment');
      final apiResponse = await http.post(url, body: bodyParams);
      final convertedResult = json.decode(apiResponse.body);
      return PaymentVaResult.fromJson(convertedResult);
    } catch (err) {
      return PaymentVaResult(state: false, message: err.toString());
    }
  }

  Future<BaseResponse> postCheckinPayLater(CheckinArgs dataCheckin) async {
    try {
      List<Map<String, dynamic>> listFnb = [];
      List<Map<String, dynamic>> listRoomPrice = [];

      if (dataCheckin.orderArgs!.fnb.fnbList.isNotEmpty) {
        for (var element in dataCheckin.orderArgs!.fnb.fnbList) {
          listFnb.add({
            'id_global': element.idGlobal,
            'id_local': element.idLocal,
            'item_name': element.itemName,
            'note': element.note,
            'location': element.location,
            'qty': element.qty,
            'price': element.price,
          });
        }
      }
      if ((dataCheckin.roomPrice?.detail ?? []).isNotEmpty) {
        dataCheckin.roomPrice?.detail?.forEach((element) {
          listRoomPrice.add({
            'room': element.room,
            'day': element.day,
            'start_time': element.startTime,
            'finish_time': element.finishTime,
            'price': element.price,
            'price_per_minute': element.pricePerMinute,
            'used_minute': element.usedMinute,
            'room_total': element.roomTotal,
            'price_total': element.priceTotal
          });
        });
      }

      final Map<String, dynamic> bodyParams = {
        'member_code': dataCheckin.orderArgs?.memberCode,
        'member_name': dataCheckin.orderArgs?.memberName,
        'pax': dataCheckin.orderArgs?.pax,
        'room_category': dataCheckin.orderArgs?.roomCategory,
        'room_code': dataCheckin.orderArgs?.roomCode,
        'checkin_duration': dataCheckin.orderArgs?.checkinDuration,
        'room_price': dataCheckin.roomPrice?.roomPrice,
        'room_service': dataCheckin.roomPrice?.serviceRoom,
        'room_tax': dataCheckin.roomPrice?.taxRoom,
        'room_total': dataCheckin.roomPrice?.priceTotal,
        'room_detail': listRoomPrice,
        'fnb_price': dataCheckin.orderArgs?.fnb.fnbTotal,
        'fnb_service': dataCheckin.orderArgs?.fnb.fnbService,
        'fnb_tax': dataCheckin.orderArgs?.fnb.fnbTax,
        'fnb_total': dataCheckin.orderArgs?.fnb.totalAll,
        'fnb_detail': listFnb,
        'payment_method': dataCheckin.payment?.paymentMethod,
        'payment_channel': dataCheckin.payment?.paymentChannel
      };

      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}checkin-paylater');
      final convertedParams = jsonEncode(bodyParams);
      final apiResponse = await http.post(url,
          body: convertedParams, headers: {'Content-Type': 'application/json'});
      final convertedResult = json.decode(apiResponse.body);
      return BaseResponse.fromJson(convertedResult);
    } catch (err) {
      return BaseResponse(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<VoucherDataResult> voucher(String memberCode) async {
    try {
      String? key = dotenv.env['key'] ?? '';
      Uri url = Uri.parse(
          'https://ihp-membership.azurewebsites.net/voucher-all?member_code=$memberCode');
      final apiResponse = await http.get(url, headers: {'Authorization': key});
      final convertedResult = json.decode(apiResponse.body);
      return VoucherDataResult.fromJson(convertedResult);
    } catch (err) {
      return VoucherDataResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<BaseResponse> checkin(
      CheckinArgs checkinArgs, String idTransaction) async {
    try {
      final dataCheckin = GenerateJsonParams().convert(checkinArgs);

      Map<String, dynamic> bodyParams = {
        'transaction_id': idTransaction,
        'payment_method': checkinArgs.payment?.paymentMethod,
        'payment_channel': checkinArgs.payment?.paymentChannel,
        'data_checkin': json.encode(dataCheckin),
      };

      final serverUrl = await baseUrl();
      final url = Uri.parse('${serverUrl}checkin');
      final apiResponse = await http.post(url, body: bodyParams);
      final convertedResult = json.decode(apiResponse.body);
      return BaseResponse.fromJson(convertedResult);
    } catch (err) {
      return BaseResponse(state: false, message: err.toString());
    }
  }

  Future<PromoRoomResult> promoRoom() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}promo-room');
      final apiResponse = await http.get(url);
      final convertedResult = json.decode(apiResponse.body);
      return PromoRoomResult.fromJson(convertedResult);
    } catch (err) {
      return PromoRoomResult(
          isLoading: false, state: false, message: err.toString());
    }
  }

  Future<PromoFoodResult> promoFood() async {
    try {
      final serverUrl = await baseUrl();
      Uri url = Uri.parse('${serverUrl}promo-food');
      final apiResponse = await http.get(url);
      final convertedResult = json.decode(apiResponse.body);
      return PromoFoodResult.fromJson(convertedResult);
    } catch (err) {
      return PromoFoodResult(
          isLoading: false, state: false, message: err.toString());
    }
  }
}
