class MemberResult {
  bool isLoading;
  bool? state;
  MemberData? data;
  String? message;

  MemberResult({this.isLoading = true, this.state, this.data, this.message});

  factory MemberResult.fromJson(Map<String, dynamic> json) {
    print('CEK STATE ' + json['state'].toString());
    if (json['state'] == false) {
      throw json['message'];
    }
    return MemberResult(
        isLoading: false,
        state: json['state'],
        message: json['message'],
        data: MemberData.fromJson(json['data']));
  }
}

class MemberData {
  String? memberCode;
  String? memberName;

  MemberData({this.memberCode, this.memberName});

  factory MemberData.fromJson(Map<String, dynamic> json) => MemberData(
        memberCode: json['member_code'],
        memberName: json['member_name'],
      );
}
