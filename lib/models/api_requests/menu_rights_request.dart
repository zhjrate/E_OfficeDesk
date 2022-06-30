class MenuRightsRequest {
  String CompanyID;
  String LoginUserID;

  MenuRightsRequest({this.CompanyID, this.LoginUserID});

  MenuRightsRequest.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyID;
    data['LoginUserID'] = this.LoginUserID;
    return data;
  }
}

