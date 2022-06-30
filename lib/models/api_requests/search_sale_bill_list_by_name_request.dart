class SearchSalesBillListByNameRequest {
  String CompanyId;
  String LoginUserID;
  String NameOnly;
  String word;


  SearchSalesBillListByNameRequest({this.CompanyId,this.LoginUserID,this.NameOnly,this.word});

  SearchSalesBillListByNameRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    NameOnly = json['needALL'];
    word = json['word'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['needALL'] = this.NameOnly;
    data['word'] = this.word;

    return data;
  }
}