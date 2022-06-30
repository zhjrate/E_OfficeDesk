class StateListRequest {
  String CompanyId;
  String CountryCode;
  String word;
  String Search;

  StateListRequest({this.CompanyId,this.CountryCode,this.word,this.Search});

  StateListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CountryCode = json['CountryCode'];
    word = json['word'];
    Search = json['Search'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CountryCode'] = this.CountryCode;
    data['word'] = this.word;
    data['Search'] = this.Search;

    return data;
  }
}