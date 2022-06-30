class ProductionActivityRequest {
  String CompanyId;
  String LoginUserID;
  String ActivityDate;
  String EmployeeID;

  ProductionActivityRequest({this.CompanyId,this.LoginUserID,this.ActivityDate,this.EmployeeID});

  ProductionActivityRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    ActivityDate = json['ActivityDate'];
    EmployeeID = json['EmployeeID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['ActivityDate'] = this.ActivityDate;
    data['EmployeeID'] = this.EmployeeID;


    return data;
  }
}

