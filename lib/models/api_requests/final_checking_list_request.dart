class FinalCheckingListRequest {
  String CompanyId;
  String LoginUserID;

  FinalCheckingListRequest({this.CompanyId,this.LoginUserID});

  FinalCheckingListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}