class LoanListRequest {
  String pkID;
  String CompanyID;

  LoanListRequest({this.pkID,this.CompanyID});

  LoanListRequest.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyId'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyID;
    data['pkID'] = this.pkID;
    return data;
  }
}

