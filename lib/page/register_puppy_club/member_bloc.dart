import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_service/data/api/api_request.dart';
import 'package:self_service/data/model/member_model.dart';

class LoginMemberCubit extends Cubit<MemberResult> {
  LoginMemberCubit() : super(MemberResult());

  void getData(String memberCode) async {
    final response = await ApiService().getMember(memberCode);
    print('DEBUGGING LOGIN STATE ' + response.state.toString());
    emit(response);
  }
}
