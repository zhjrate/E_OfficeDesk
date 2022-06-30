class SearchInquiryListByNumberRequest {
  String searchKey;
  String pkId;
  String CompanyId;
  String LoginUserID;

  SearchInquiryListByNumberRequest({this.searchKey, this.pkId = "",this.CompanyId,this.LoginUserID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Searchkey'] = this.searchKey;
    data['PkId'] = this.pkId;
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    return data;
  }
}
