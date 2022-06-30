class InquirySearchByPkIdRequest {
  String CompanyId;

  String LoginUserID;



  InquirySearchByPkIdRequest({this.CompanyId,this.LoginUserID});

  InquirySearchByPkIdRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];

    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID']=this.LoginUserID;

    return data;
  }
}