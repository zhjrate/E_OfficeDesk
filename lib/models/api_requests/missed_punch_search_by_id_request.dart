class MissedPunchSearchByIDRequest {
  String CompanyID;
  String LoginUserID;

  MissedPunchSearchByIDRequest({this.CompanyID, this.LoginUserID});

  MissedPunchSearchByIDRequest.fromJson(Map<String, dynamic> json) {
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

