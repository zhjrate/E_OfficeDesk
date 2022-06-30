class CustomerSourceRequest {
  int companyId;
  String StatusCategory;
  String pkID;
  String LoginUserID;
  String SearchKey;

  /*

   CompanyId:10032
pkID:
StatusCategory:InquirySource
LoginUserID:admin
SearchKey:

  */



  CustomerSourceRequest({this.companyId, this.StatusCategory,this.pkID,this.LoginUserID,this.SearchKey});

  CustomerSourceRequest.fromJson(Map<String, dynamic> json) {
    companyId = json['CompanyId'];
    StatusCategory = json['StatusCategory'];
    pkID = json['pkID'];
    LoginUserID = json['LoginUserID'];
    SearchKey =  json['SearchKey'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.companyId;
    data['StatusCategory'] = this.StatusCategory;
    data['pkID'] = this.pkID;
    data['LoginUserID'] = this.LoginUserID;
    data['SearchKey'] = this.SearchKey;

    return data;
  }
}