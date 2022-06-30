class SearchInquiryListByNameRequest {
  String CompanyId;
  String LoginUserID;
  String needALL;
  String word;


  /*CompanyId:10032
CustomerName:Sharv
ProductName:Test M
InquiryNo:
StateCode:
CityCode:
CountryCode:
Priority:
NameOnly:1
Word:*/


  SearchInquiryListByNameRequest({this.CompanyId,this.LoginUserID,this.word,this.needALL});

  SearchInquiryListByNameRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    word = json['word'];
    needALL = json['needALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['word'] = this.word;
    data['needALL'] = this.needALL;

    return data;
  }
}
