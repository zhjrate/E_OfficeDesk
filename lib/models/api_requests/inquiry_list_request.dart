class InquiryListApiRequest {
  String CompanyId;
  String LoginUserID;
  String PkId;

  InquiryListApiRequest({this.CompanyId,this.LoginUserID,this.PkId});

  InquiryListApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    PkId= json['PkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['PkID'] = this.PkId;

    return data;
  }
}