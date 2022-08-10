class SalesBillSearchByNameRequest {
  String CompanyId;
  String word;
  String needALL;
  String LoginUserID;

  SalesBillSearchByNameRequest(
      this.CompanyId, this.word, this.needALL, this.LoginUserID);

  SalesBillSearchByNameRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    word = json['word'];
    needALL = json['needALL'];
    LoginUserID = json['LoginUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['word'] = this.word;
    data['needALL'] = this.needALL;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}
