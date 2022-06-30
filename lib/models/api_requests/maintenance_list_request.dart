class MaintenanceListRequest {
  String pkID;
  String CompanyID;
  String LoginUserID;

  MaintenanceListRequest({this.pkID,this.CompanyID, this.LoginUserID});

  MaintenanceListRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    CompanyID = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['CompanyId'] = this.CompanyID;
    data['LoginUserID'] = this.LoginUserID;
    return data;
  }
}

