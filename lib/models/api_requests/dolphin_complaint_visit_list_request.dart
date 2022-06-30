class DolphinComplaintVisitListRequest {
  String CompanyId;
  String LoginUserID;

  DolphinComplaintVisitListRequest({this.CompanyId,this.LoginUserID});

  DolphinComplaintVisitListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = "11050";
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}