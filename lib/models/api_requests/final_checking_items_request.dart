class FinalCheckingItemsRequest {
  String CompanyId;
  String LoginUserID;

  FinalCheckingItemsRequest({this.CompanyId,this.LoginUserID});

  FinalCheckingItemsRequest.fromJson(Map<String, dynamic> json) {
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