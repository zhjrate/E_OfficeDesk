class FollowupInquiryStatusTypeListRequest {
  String CompanyId;
  String pkID;
  String StatusCategory;
  String LoginUserID;
  String SearchKey;


  FollowupInquiryStatusTypeListRequest({this.CompanyId,this.pkID,this.StatusCategory,this.LoginUserID,this.SearchKey});

  FollowupInquiryStatusTypeListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    pkID = json['pkID'];
    StatusCategory = json['StatusCategory'];
    LoginUserID = json['LoginUserID'];
    SearchKey = json['SearchKey'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['pkID'] = this.pkID;
    data['StatusCategory']=this.StatusCategory;
    data['LoginUserID']=this.LoginUserID;
    data['SearchKey']=this.SearchKey;

    return data;
  }
}