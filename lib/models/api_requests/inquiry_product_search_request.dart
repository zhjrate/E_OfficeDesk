/*
pkID:
ListMode:L
SearchKey:test
CompanyId:10032*/
class InquiryProductSearchRequest {
  String pkID;
  String CompanyId;
  String ListMode;
  String SearchKey;


  InquiryProductSearchRequest({this.CompanyId,this.pkID,this.ListMode,this.SearchKey});

  InquiryProductSearchRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    CompanyId = json['CompanyId'];
    ListMode = json['ListMode'];
    SearchKey = json['SearchKey'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['CompanyId'] = this.CompanyId;
    data['ListMode']=this.ListMode;
    data['SearchKey']=this.SearchKey;

    return data;
  }
}