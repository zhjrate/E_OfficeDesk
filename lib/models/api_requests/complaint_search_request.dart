class ComplaintSearchRequest {
  String LoginUserID;
  String CompanyID;
  String word;
  String needALL;

  ComplaintSearchRequest({this.LoginUserID,this.CompanyID,this.word,this.needALL});

  ComplaintSearchRequest.fromJson(Map<String, dynamic> json) {
    LoginUserID = json['LoginUserID'];
    CompanyID = json['CompanyId'];
    word = json['word'];
    needALL = json['needALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyID;
    data['word'] = this.word;
    data['needALL'] = this.needALL;

    return data;
  }
}