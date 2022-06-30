class MissedPunchListRequest {
  String CompanyID;
  String LoginUserID;

  MissedPunchListRequest({this.CompanyID, this.LoginUserID});

  MissedPunchListRequest.fromJson(Map<String, dynamic> json) {
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

