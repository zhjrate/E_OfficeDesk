class MissedPunchSearchByNameRequest {
  String CompanyID;
  String LoginUserID;
  String word;
  String needALL;

  MissedPunchSearchByNameRequest({this.CompanyID, this.LoginUserID,this.word,this.needALL});

  MissedPunchSearchByNameRequest.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    word = json['word'];
    needALL = json['needALL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyID;
    data['LoginUserID'] = this.LoginUserID;
    data['word'] = this.word;
    data['needALL'] = this.needALL;

    return data;
  }
}

