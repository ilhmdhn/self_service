import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/base_response.dart';
import 'package:self_service/data/model/list_payment.dart';
import 'package:self_service/data/model/payment_qris.dart';
import 'package:self_service/data/model/payment_va.dart';
import 'package:self_service/util/order_args.dart';

class PaymentListCubit extends Cubit<ListPaymentResult> {
  PaymentListCubit() : super(ListPaymentResult());

  void getData() async {
    // final response = await ApiTest().getPaymentMethod();
    final response = await ApiService().listPaymentMethod();
    emit(response);
  }

  void updateData(ListPaymentResult data) {
    emit(data);
  }
}

class PaymentQrisCubit extends Cubit<QrisPaymentResult> {
  PaymentQrisCubit() : super(QrisPaymentResult());

  void getData(
      String paymentMethod,
      String paymentChannel,
      num amount,
      String customer,
      String phone,
      String email,
      CheckinArgs dataCheckin) async {
    final response = await ApiService().getQrisPayment(paymentMethod,
        paymentChannel, amount, customer, phone, email, dataCheckin);
    emit(response);
  }
}

class PaymentVaCubit extends Cubit<PaymentVaResult> {
  PaymentVaCubit() : super(PaymentVaResult());

  void getData(
      String paymentMethod,
      String paymentChannel,
      num amount,
      String customer,
      String phone,
      String email,
      CheckinArgs dataCheckin) async {
    final response = await ApiService().getVaPayment(paymentMethod,
        paymentChannel, amount, customer, phone, email, dataCheckin);
    emit(response);
  }
}

class PostCheckinCubit extends Cubit<BaseResponse> {
  PostCheckinCubit() : super(BaseResponse());

  void setData(CheckinArgs checkinArgs, String idTransaction) async {
    final response = await ApiService().checkin(checkinArgs, idTransaction);
    emit(response);
  }
}
