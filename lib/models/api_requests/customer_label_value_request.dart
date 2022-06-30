class CustomerLabelValueRequest {
  String CompanyId;
  String LoginUserID;
  String word;


  CustomerLabelValueRequest({this.CompanyId,this.LoginUserID,this.word});

  CustomerLabelValueRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['word'] = this.word;

    return data;
  }
}