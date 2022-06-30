class QuotationListApiRequest {
  String CompanyId;
  String LoginUserID;
  String pkId;

  QuotationListApiRequest({this.CompanyId,this.LoginUserID,this.pkId});

  QuotationListApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    pkId= json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
   // data['pkID'] = this.pkId;

    return data;
  }
}